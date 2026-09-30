# Git

None of these have config files; all run on defaults. LazyGit is a separate
program: `:terminal lazygit` or `:TermExec cmd=lazygit` (toggleterm).

## vim-fugitive

`:Git` (or `:G`) opens the status window. Any git subcommand works:
`:Git commit`, `:Git push`, `:Git pull`, `:Git log`, `:Git blame`,
`:Git diff`, `:Git checkout <branch>`.

Other commands: `:Gdiffsplit` (diff current file against index),
`:Gvdiffsplit`, `:Gread` (revert buffer to index version), `:Gwrite`
(stage the file), `:GMove`, `:GDelete`, `:GBrowse` (needs a remote handler).

Keys in the `:Git` status window (`g?` for all):

| Key | Action |
|---|---|
| `s` / `u` / `-` | stage / unstage / toggle file or hunk under cursor |
| `=` | inline diff of the file |
| `dv` | vertical diff split |
| `cc` | commit |
| `ca` | amend commit |
| `X` | discard change under cursor |
| `<CR>` | open file |
| `)` / `(` | next / previous file or hunk |

## gitsigns

Auto-enables in git repos (no config file). Sign column shows `┃` added/changed,
`▁` deleted below, `▔` deleted above (top), `~` changed+deleted, `┆` untracked. There are **no default keymaps**.

Commands: `:Gitsigns next_hunk` / `prev_hunk`, `:Gitsigns preview_hunk`,
`:Gitsigns preview_hunk_inline`, `:Gitsigns stage_hunk`, `:Gitsigns reset_hunk`,
`:Gitsigns stage_buffer`, `:Gitsigns reset_buffer`, `:Gitsigns blame_line`,
`:Gitsigns blame`, `:Gitsigns toggle_current_line_blame`, `:Gitsigns diffthis`,
`:Gitsigns setqflist` (all hunks to quickfix).

In diff mode, Neovim's built-in `]c` / `[c` jump between changes.

## git-messenger

`:GitMessenger` pops up the commit that last touched the current line (author,
date, message). Default mapping `<leader>gm`; with no `mapleader` set this is
`\gm`. In the popup: `o` older commit, `O` newer commit, `d` / `D` diff,
`q` close.
