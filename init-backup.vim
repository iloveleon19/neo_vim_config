" ===========================
" vim-plug 插件管理
" ===========================
call plug#begin('~/.vim/plugged')

" Lightline 狀態列
Plug 'itchyny/lightline.vim'

" Git 顯示
Plug 'tpope/vim-fugitive'

" Git 訊息彈窗
Plug 'rhysd/git-messenger.vim'

" 文件瀏覽器
Plug 'preservim/nerdtree'

Plug 'lewis6991/gitsigns.nvim'

".GitHub.Copilot
Plug 'github/copilot.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Mofiqul/vscode.nvim'

call plug#end()

set mouse=

" ==============================
" gitsigns.nvim 設定
" ==============================
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
EOF

" 啟用 lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

set encoding=utf-8
set fileencoding=utf-8

" 顯示空白與換行
set list
set laststatus=2
set noshowmode

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1

"設定顯示字符
set listchars=space:.,tab:>-,trail:.
highlight SpecialKey ctermfg=DarkGray guifg=Gray
set number
set relativenumber
set ruler
set termguicolors
syntax enable

