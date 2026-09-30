---
name: nvim-config
description: How to use and maintain this Neovim setup (neo_vim_config) — plugin commands, default keys, LSP/completion, and the rules for changing the config. Use when the user asks how to do something in nvim, what a key or plugin does, why something looks or behaves oddly, or wants to add, remove, or configure a plugin in this repo.
---

# neo_vim_config

Neovim 0.11 config using native packages. Answer from THIS setup's actual
state, not generic Neovim advice: many plugins run on defaults and there are
almost no custom keymaps.

## Layout

- No `init.lua`. Plugins live in `~/.local/share/nvim/site/pack/neo_vim_config/start/`
  and load automatically.
- `~/.config/nvim/after` is a symlink to this repo's `after/`. Each plugin's
  config is `after/plugin/<plugin>.lua`, loaded in filename order after all plugins.
- Neovim's own options go in `after/plugin/options.lua`. `mapleader` is not set
  (default `\`). If leader keymaps are added, set `mapleader` at the top of
  `options.lua` and put every `<leader>` mapping in that same file.
- `plugins.json` lists plugins; `scripts/plugins.py install|update|migrate` manages them.
- `README.md` documents the setup — keep it in sync when changing config.

## Rules for changing the config (user preferences)

1. **Prefer plugin defaults.** Only override what is necessary. When a feature
   needs extra settings beyond a plain `setup()`, explain the options and let the
   user choose before writing them.
2. **Do not copy from the old config** (`backups/init-v3-a6e81a7.lua`,
   `backups/init-backup.vim`). It may be read for reference and shown
   to the user, but port nothing without asking.
3. **No Nerd Font.** The user has none installed and does not want one. Any icon
   in the Private Use Area (U+E000–U+F8FF, U+F0000+) renders as tofu or random
   CJK glyphs. `nvim-web-devicons` was removed on purpose. When adding a plugin,
   grep its defaults for PUA glyphs and override them with ASCII:
   `grep -nP '[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}]' <plugin>/lua -r`
4. **Few config files.** One file per plugin in `after/plugin/`; no extra layers.
5. **Removing a plugin:** delete it from `plugins.json`, delete its directory from
   `start/` (the script never deletes), and delete its `after/plugin/` file.
   **Adding:** add to `plugins.json`, `git clone --depth 1` into `start/` (or run
   `python3 scripts/plugins.py install`), add a config file if it needs `setup()`.
6. Verify changes headlessly, e.g.
   `nvim --headless <file> -c 'sleep 1000m' -c 'lua ...' -c 'qa!'`, and check for
   errors and PUA glyphs in rendered output.

## Plugin reference

Read the file for the area the question is about:

| Area | Plugins | File |
|---|---|---|
| Files, search, buffers, outline | neo-tree, telescope (+fzf-native), bufferline, bufdelete, aerial | `references/files-search.md` |
| Git | vim-fugitive, gitsigns, git-messenger | `references/git.md` |
| LSP, completion, snippets, spelling | mason, mason-lspconfig, nvim-lspconfig, lazydev, nvim-cmp (+5 sources), LuaSnip, friendly-snippets, cspell_ls, nvim-navic | `references/lsp-completion.md` |
| Display, editing, terminal | lualine, treesitter, treesitter-context, toggleterm, options.lua | `references/ui-editing.md` |

Libraries with nothing to configure: plenary (telescope, neo-tree), nui and
nvim-window-picker (neo-tree).
