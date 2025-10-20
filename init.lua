-- ===========================
-- 基本設定
-- ===========================
vim.opt.mouse = ''
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.list = true
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.termguicolors = true
vim.cmd('syntax enable')

-- 設定顯示字符
vim.opt.listchars = { space = '.', tab = '>-', trail = '.' }
vim.cmd('highlight SpecialKey ctermfg=DarkGray guifg=Gray')

-- ===========================
-- vim-plug 插件管理
-- ===========================
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

-- Lightline 狀態列
Plug('itchyny/lightline.vim')

-- Git 顯示
Plug('tpope/vim-fugitive')

-- Git 訊息彈窗
Plug('rhysd/git-messenger.vim')

-- 文件瀏覽器
Plug('preservim/nerdtree')

-- Git signs
Plug('lewis6991/gitsigns.nvim')

-- GitHub Copilot
Plug('github/copilot.vim')

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- VSCode 主題
Plug('Mofiqul/vscode.nvim')

vim.call('plug#end')

-- ==============================
-- gitsigns.nvim 設定
-- ==============================
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

-- ==============================
-- lightline 設定
-- ==============================
vim.g.lightline = {
  colorscheme = 'wombat',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  },
  component_function = {
    gitbranch = 'FugitiveHead'
  },
}

-- ==============================
-- better_whitespace 設定
-- ==============================
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
