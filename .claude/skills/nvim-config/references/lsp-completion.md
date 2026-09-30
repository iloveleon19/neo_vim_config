# LSP, completion, snippets, spelling

## Servers (mason + mason-lspconfig + nvim-lspconfig)

`after/plugin/mason.lua` sets up mason then mason-lspconfig (order matters, so
both live in one file). `ensure_installed` auto-installs missing servers on
startup: lua_ls, ts_ls, pyright, gopls, rust_analyzer, clangd, html, cssls,
jsonls, intelephense, marksman (Markdown), cspell_ls (spelling).
mason-lspconfig auto-enables every installed server via `vim.lsp.enable`.
nvim-lspconfig only supplies server configs; it has no config file.

- Toolchains on this machine: node/npm, Go 1.26 (gopls needs `go`), Rust via
  rustup stable (rust-analyzer needs `cargo`), PHP 8.5.
- Add a language: `:Mason` (UI: `i` install, `X` uninstall, `U` update all,
  `g?` help) or `:LspInstall <server>`. To make it permanent, add it to
  `ensure_installed`.
- Per-server settings: `vim.lsp.config('<server>', { settings = ... })`.
- Debug: `:checkhealth vim.lsp`, `:LspInfo`, `:LspLog`, `:LspRestart`.

Keys (Neovim 0.11 built-ins, active when a server is attached):

| Key | Action |
|---|---|
| `K` | hover docs |
| `grn` | rename |
| `gra` | code action |
| `grr` | references |
| `gri` | implementation |
| `gO` | document symbols |
| `<C-s>` (insert) | signature help |
| `[d` / `]d` | previous / next diagnostic |
| `<C-w>d` | diagnostic float under cursor |

Go to definition: `<C-]>` (uses LSP tagfunc) or `:lua vim.lsp.buf.definition()`.
Format: `:lua vim.lsp.buf.format()`. Diagnostics are shown as underlines and
signs only; virtual text at line end is off (Neovim 0.11 default).

## lazydev

`after/plugin/lazydev.lua`: makes lua_ls understand the Neovim API when editing
Neovim Lua files, giving `vim.*` completion and no "undefined global vim".

## Spelling (cspell_ls)

Same engine as VS Code's Code Spell Checker. Attaches to most filetypes; flags
unknown words as diagnostics (`cSpell: "xyz": Unknown word.`). Checks
camelCase parts separately. False positives (e.g. `nvim`, `navic`, `winbar`)
need a `cspell.json` / `.cspell.json` with `"words": [...]` in the project;
none exists yet. Neovim's built-in `:set spell` is off (would duplicate).

## Completion (nvim-cmp)

`after/plugin/nvim-cmp.lua`. Menu opens automatically while typing.

Sources: group 1 = LSP (`[LSP]`), LuaSnip (`[Snippet]`); group 2, used only when
group 1 has nothing = buffer words (`[Buffer]`), paths (`[Path]`). Items show a
kind abbreviation, e.g. `F Function`, `M Method`, `V Variable`, `Cl Class`,
`S Snippet`. Menu and docs windows have borders. The config also passes
cmp-nvim-lsp capabilities to all servers via `vim.lsp.config('*', ...)`.

Keys (cmp's `preset.insert`, deliberately no extras):

| Key (insert) | Action |
|---|---|
| `<C-n>` / `<C-p>`, arrows | next / previous item; `<C-n>`/`<C-p>` open the menu when closed |
| `<C-y>` | confirm |
| `<C-e>` | close menu |

`<CR>` is NOT bound to confirm, and `<Tab>` is not used by cmp.

Cmdline: `/` search suggests buffer words; `:` suggests paths and commands.
There `<Tab>` / `<S-Tab>` / `<C-n>` / `<C-p>` select; `<CR>` runs as usual.

## Snippets (LuaSnip + friendly-snippets)

`after/plugin/LuaSnip.lua` loads friendly-snippets (VS Code-format snippets for
many languages) and maps `<Tab>` / `<S-Tab>` in insert/select mode: inside a
snippet, jump to next / previous field; otherwise insert a normal Tab. This
mirrors Neovim's built-in `vim.snippet` Tab behavior.

Usage: type a prefix (e.g. `def` in Python, `for` in JS), pick the `[Snippet]`
item, `<C-y>` to expand, type to replace the selected placeholder, `<Tab>` to
the next field. LSP snippet completions (function args) also expand via LuaSnip.

Custom snippets: none yet. VS Code-format JSON snippets can be added in a
directory with a `package.json` and loaded with
`require('luasnip.loaders.from_vscode').lazy_load({ paths = { '<dir>' } })`.

## nvim-navic (breadcrumbs)

`after/plugin/nvim-navic.lua`: auto-attaches to LSP servers with document
symbols; text abbreviations for kinds (`F`, `Cl`, `M`...), separator ` > `.
Shown in the winbar at the top of each window via lualine; appears only when
an LSP server is attached.
