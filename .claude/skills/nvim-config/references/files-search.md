# Files, search, buffers, outline

No global keymaps are defined for these plugins; use commands unless the user
adds mappings.

## neo-tree (file tree)

Config `after/plugin/neo-tree.lua`: ASCII icons only. Folders `+` closed / `-`
open; files have no icon. Git status symbols: `A` added, `M` modified,
`D` deleted, `R` renamed, `?` untracked, `I` ignored, `U` unstaged, `S` staged,
`!` conflict.

Commands: `:Neotree` (open/focus), `:Neotree toggle`, `:Neotree close`,
`:Neotree reveal` (jump to current file), `:Neotree float`,
`:Neotree buffers`, `:Neotree git_status`.

Default keys inside the tree (`?` shows all):

| Key | Action |
|---|---|
| `<CR>` / double-click | open |
| `<space>` | expand/collapse folder |
| `s` / `S` / `t` | open in vsplit / split / new tab |
| `w` | open with window picker |
| `P` | toggle floating preview (`l` focus preview) |
| `a` / `A` | add file (end with `/` for a dir) / add directory |
| `d` / `r` / `b` | delete / rename / rename basename |
| `c` / `m` | copy / move (prompts for destination) |
| `y` / `x` / `p` | copy / cut / paste via neo-tree clipboard |
| `H` | toggle hidden files |
| `/` | fuzzy find in tree; `f` filter; `<C-x>` clear filter |
| `<BS>` / `.` | go up / set root to node |
| `[g` / `]g` | previous / next git-modified file |
| `i` | file details |
| `o` + `n/s/m/t/g/d/c` | order by name/size/modified/type/git/diagnostics/created |
| `C` / `z` | close node / close all |
| `R` | refresh |
| `<` / `>` | previous / next source (filesystem, buffers, git_status) |
| `q` | close window |

## telescope (fuzzy finder)

`after/plugin/telescope.lua` loads the fzf-native sorter. Needs ripgrep for grep.

Common pickers: `:Telescope find_files`, `live_grep` (search text in project),
`grep_string` (word under cursor), `buffers`, `oldfiles`, `help_tags`,
`git_files`, `git_status`, `git_commits`, `current_buffer_fuzzy_find`,
`command_history`, `diagnostics`, `lsp_references`, `lsp_document_symbols`,
`keymaps`, `resume` (reopen last picker). `:Telescope` alone lists all pickers.

Keys in the prompt (insert mode):

| Key | Action |
|---|---|
| `<C-n>` / `<C-p>`, arrows | next / previous result |
| `<CR>` | open |
| `<C-x>` / `<C-v>` / `<C-t>` | open in split / vsplit / tab |
| `<C-u>` / `<C-d>` | scroll preview |
| `<Tab>` / `<S-Tab>` | toggle multi-select |
| `<C-q>` | send all results to quickfix |
| `<M-q>` | send selected results to quickfix |
| `<C-/>` | show key help |
| `<Esc>` (normal mode) / `<C-c>` | close |

## bufferline (tab bar of buffers)

Config `after/plugin/bufferline.lua`: only ASCII close (`x`, `X`) and truncation
(`<`, `>`) markers. Modified buffers show `●`.

Mouse: click a tab to switch, click `x` or right-click to close.
Commands: `:BufferLineCycleNext` / `Prev`, `:BufferLinePick`,
`:BufferLineGoToBuffer N`, `:BufferLineMoveNext` / `Prev`,
`:BufferLineCloseLeft` / `Right` / `Others`, `:BufferLineTogglePin`,
`:BufferLineSortByDirectory` / `ByExtension`.
Built-in alternatives: `:bnext`, `:bprev`, `:b <name>`.

## bufdelete

`:Bdelete` / `:Bdelete!` close a buffer without closing its window or messing up
the layout (`:bd` closes the window too). `:Bwipeout` also exists. Bufferline's
close button still uses plain `bdelete`.

## aerial (code outline)

`after/plugin/aerial.lua`: plain `setup()`. Uses treesitter/LSP for symbols;
plain-text icons because devicons is absent.

Commands: `:AerialToggle` (sidebar, focus moves), `:AerialToggle!` (keep focus),
`:AerialOpen`, `:AerialClose`, `:AerialNavToggle` (floating navigator),
`:AerialNext` / `:AerialPrev`.

Keys in the aerial window (`?` or `g?` for help): `<CR>` jump, `<C-v>` / `<C-s>`
jump in vsplit / split, `p` scroll to symbol, `<C-j>` / `<C-k>` move and scroll,
`{` / `}` previous / next symbol, `[[` / `]]` up a level, `o` / `za` toggle fold,
`l` / `h` open / close, `zR` / `zM` open / close all, `q` close.
