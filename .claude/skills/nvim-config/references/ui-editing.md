# Display, editing, terminal

## options.lua (Neovim's own settings)

- `number`, `relativenumber`: line numbers, relative to cursor.
- `list` with `listchars = { space = '.', tab = '>-', trail = '.' }`: every
  space shows as `.`, tabs as `>-`. Trailing spaces also show as `.`, so they
  look like other spaces; trailing tabs use the `tab` symbol. Non-breaking
  spaces (U+00A0) use Neovim's default `+`.
- `showmode = false`: mode is shown only in lualine.
- Everything else is Neovim default: mouse on, tabs are real tab characters
  (ftplugins set per-language indent, e.g. Python 4 spaces), no spell,
  `mapleader` unset (`\`). The user tried 1-space Tab indent and reverted it.

## lualine (status line)

`after/plugin/lualine.lua`: `icons_enabled = false`, component separator `|`,
no section separators, `globalstatus = true` (one status line at the bottom
for all splits), winbar shows nvim-navic location. Theme follows the current
colorscheme (Neovim default; tokyonight and vscode themes were removed).

Default sections: mode | git branch, diff (`+~-`), diagnostics (`E:` `W:` `I:`
`H:`) | filename | encoding, fileformat (`unix`), filetype | progress | location.

## nvim-treesitter

`after/plugin/nvim-treesitter.lua`: highlight enabled; indent not enabled.
Branch pinned to `master`. Parsers installed by `scripts/post-install.lua`:
lua, vim, vimdoc, javascript, typescript, python, go, rust, html, css, c, php
(plus a few bundled with Neovim). Add more with `:TSInstall <lang>`, update with
`:TSUpdate`, inspect with `:TSInstallInfo`, `:Inspect`, `:InspectTree`.

## nvim-treesitter-context

No config file; auto-enabled. Pins the current function/class header at the
top of the window while scrolling. `:TSContext toggle` / `enable` / `disable`.

## toggleterm (terminal)

`after/plugin/toggleterm.lua`: plain `setup()`. **No open mapping** is set.

- `:ToggleTerm` toggles terminal 1 (default horizontal split).
- `:ToggleTerm direction=float` (also `vertical`, `tab`), `:2ToggleTerm` for
  terminal 2, `:ToggleTermToggleAll`.
- `:TermExec cmd="npm test"` runs a command; `:TermExec cmd=lazygit direction=float`.
- `:TermSelect` picks a terminal; `:ToggleTermSendCurrentLine`,
  `:ToggleTermSendVisualSelection` send code to the terminal.
- Leave terminal insert mode with `<C-\><C-n>`; `i` to type again.
