#!/usr/bin/env python3
"""Manage Git checkouts in Neovim's automatically loaded start packages."""
import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def run(*args, cwd=None):
    result = subprocess.run(args, cwd=cwd, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f"{' '.join(map(str, args))}\n{result.stderr or result.stdout}")
    return result.stdout.strip()


def sync_plugin(plugin, base, update=False):
    name = plugin['repo'].split('/')[-1]
    target = base / name
    url = 'https://github.com/' + plugin['repo'] + '.git'
    if target.exists():
        if not (target / '.git').is_dir():
            raise RuntimeError(f'{target} is not a Git checkout; leave it untouched.')
        if run('git', 'remote', 'get-url', 'origin', cwd=target) != url:
            raise RuntimeError(f'{target}: unexpected origin; leave it untouched.')
        if not update:
            return target
        if run('git', 'status', '--porcelain', cwd=target):
            raise RuntimeError(f'{target}: local changes; refusing to update.')
    else:
        # Rename only after cloning/checking out successfully, so failed installs
        # do not look like usable packages on the next startup.
        with tempfile.TemporaryDirectory(prefix=f'.{name}-', dir=base) as tmp:
            checkout = Path(tmp) / name
            run('git', 'clone', '--filter=blob:none', url, str(checkout))
            select_version(plugin, checkout)
            checkout.rename(target)
        return target
    run('git', 'fetch', '--tags', 'origin', cwd=target)
    select_version(plugin, target, updating=True)
    return target


def select_version(plugin, target, updating=False):
    if plugin.get('release'):
        tags = run('git', 'tag', '--sort=-version:refname', cwd=target).splitlines()
        stable = [tag for tag in tags if re.fullmatch(r'v?\d+\.\d+\.\d+', tag)]
        if not stable:
            raise RuntimeError(f'{target}: no stable release tags found.')
        ref = 'refs/tags/' + stable[0]
    elif plugin.get('tag'):
        ref = 'refs/tags/' + plugin['tag']
    elif plugin.get('branch'):
        ref = 'refs/remotes/origin/' + plugin['branch']
    else:
        ref = run('git', 'symbolic-ref', 'refs/remotes/origin/HEAD', cwd=target)
    if updating:
        # Do not discard local commits or rewrite history on an upstream force push.
        run('git', 'merge-base', '--is-ancestor', 'HEAD', ref, cwd=target)
    run('git', 'checkout', '--detach', ref, cwd=target)


def migrate_layout(data, config, plugins):
    """Move listed opt packages intact and connect per-plugin configuration."""
    package_root = data / 'site' / 'pack' / 'neo_vim_config'
    start = package_root / 'start'
    after = config / 'after'
    init = config / 'init.lua'
    # Validate everything before moving anything. Never replace user config.
    if after.exists() or after.is_symlink():
        if not after.is_symlink() or after.resolve() != (ROOT / 'after').resolve():
            raise RuntimeError(f'{after}: existing configuration; refusing to replace it.')
    if init.exists() or init.is_symlink():
        if not init.is_symlink() or init.resolve() != ROOT / 'init.lua':
            raise RuntimeError(f'{init}: existing configuration; refusing to remove it.')
    if (config / 'init.vim').exists():
        raise RuntimeError(f'{config / "init.vim"}: existing configuration; please review it first.')
    moves = []
    for plugin in plugins:
        name = plugin['repo'].split('/')[-1]
        old, new = package_root / 'opt' / name, start / name
        if old.exists() or old.is_symlink():
            if new.exists() or new.is_symlink():
                raise RuntimeError(f'{name}: present in both opt and start; refusing to overwrite.')
            moves.append((old, new))
    start.mkdir(parents=True, exist_ok=True)
    config.mkdir(parents=True, exist_ok=True)
    for old, new in moves:
        old.rename(new)
        print(f'Moved: {new.name}', flush=True)
    if not after.is_symlink():
        after.symlink_to(ROOT / 'after', target_is_directory=True)
    if init.is_symlink():
        init.unlink()
    print(f'Native start packages: {start}\nPer-plugin configuration: {after}')
    return start


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['install', 'update', 'migrate'])
    args = parser.parse_args()
    required = ('nvim',) if args.action == 'migrate' else ('git', 'nvim', 'make', 'cc')
    missing = [tool for tool in required if not shutil.which(tool)]
    if missing:
        raise RuntimeError('Missing tools: ' + ', '.join(missing)
                           + '\nUbuntu: sudo apt install git neovim build-essential')
    # Let Neovim resolve XDG paths and NVIM_APPNAME without loading any plugins.
    paths = json.loads(run('nvim', '--headless', '-u', 'NONE', '-i', 'NONE', '-l',
                           str(ROOT / 'scripts' / 'paths.lua')))
    plugins = json.loads((ROOT / 'plugins.json').read_text())
    base = migrate_layout(Path(paths['data']), Path(paths['config']), plugins)
    if args.action == 'migrate':
        return
    for plugin in plugins:
        print(f"{args.action}: {plugin['repo']}", flush=True)
        target = sync_plugin(plugin, base, update=args.action == 'update')
        if plugin.get('build') == 'make':
            run('make', cwd=target)
    # Use a small init, so installing does not start Mason or load the full UI.
    run('nvim', '--headless', '-u', 'NONE', '-i', 'NONE', '-l',
        str(ROOT / 'scripts' / 'post-install.lua'))
    print('完成。重新開啟 Neovim；額外設定放在 after/plugin/*.lua。')


if __name__ == '__main__':
    try:
        main()
    except (RuntimeError, OSError) as exc:
        print(exc, file=sys.stderr)
        sys.exit(1)
