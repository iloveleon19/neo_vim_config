-- ===========================
-- 基本設定
-- ===========================
-- 設定 Leader 鍵為空白鍵（必須在所有快捷鍵設定之前）
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 檢測 Guacamole/SSH 環境，使用簡化圖標
vim.g.use_nerd_fonts = (os.getenv("SSH_CONNECTION") == nil and os.getenv("SSH_CLIENT") == nil)

vim.opt.mouse = ''
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.list = true
vim.opt.laststatus = 3  -- 全局狀態列（與 lualine 搭配更佳）
vim.opt.cmdheight = 1   -- 命令列高度（顯示命令和訊息）
vim.opt.showmode = false  -- 關閉模式顯示（lualine 已顯示）
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.termguicolors = true
vim.cmd('syntax enable')

-- 拼寫檢查設定
vim.opt.spell = true  -- 預設開啟（可用 <leader>s 或 :set spell 手動關閉）
vim.opt.spelllang = { 'en_us', 'cjk' }  -- 英文 + 中日韓文字
vim.opt.spelloptions = 'camel'  -- 支持 camelCase、snake_case、PascalCase 檢查

-- 設定顯示字符
vim.opt.listchars = { space = '.', tab = '>-', trail = '.' }

-- ===========================
-- vim-plug 插件管理
-- ===========================
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

-- lualine 狀態列
Plug('nvim-lualine/lualine.nvim')

-- Git 顯示
Plug('tpope/vim-fugitive')

-- Git 訊息彈窗
Plug('rhysd/git-messenger.vim')

-- Git signs
Plug('lewis6991/gitsigns.nvim')

-- GitHub Copilot
Plug('github/copilot.vim')

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Treesitter Context - 顯示當前程式碼上下文
Plug('nvim-treesitter/nvim-treesitter-context')

-- LSP 配置
Plug('neovim/nvim-lspconfig')  -- LSP 配置集合
Plug('williamboman/mason.nvim')  -- LSP 安裝管理器
Plug('williamboman/mason-lspconfig.nvim')  -- Mason 與 lspconfig 的橋接

-- 自動補全
Plug('hrsh7th/nvim-cmp')  -- 補全引擎
Plug('hrsh7th/cmp-nvim-lsp')  -- LSP 補全源
Plug('hrsh7th/cmp-buffer')  -- Buffer 補全源
Plug('hrsh7th/cmp-path')  -- 路徑補全源
Plug('hrsh7th/cmp-cmdline')  -- 命令列補全
Plug('L3MON4D3/LuaSnip')  -- Snippet 引擎
Plug('saadparwaiz1/cmp_luasnip')  -- Snippet 補全源

-- -- VSCode 主題
Plug('Mofiqul/vscode.nvim')

-- Neo-tree 文件瀏覽器及其依賴
Plug('nvim-lua/plenary.nvim')  -- Neo-tree 依賴
Plug('nvim-tree/nvim-web-devicons')  -- 文件圖標
Plug('MunifTanjim/nui.nvim')  -- UI 組件庫
Plug('s1n7ax/nvim-window-picker')  -- 窗口選擇器
Plug('nvim-neo-tree/neo-tree.nvim', { ['branch'] = 'v3.x' })

-- Bufferline 頁簽顯示
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

-- 終端機彈窗
Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' })

-- 智能關閉 buffer（避免關閉後佈局混亂）
Plug('famiu/bufdelete.nvim')

-- Telescope 模糊搜尋工具
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

-- Breadcrumbs - 顯示當前函數/類別位置（類似 VSCode）
Plug('SmiteshP/nvim-navic')

-- Aerial - 代碼大綱視圖（類似 VSCode Outline）
Plug('stevearc/aerial.nvim')

Plug('folke/tokyonight.nvim')

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
-- nvim-treesitter 設定
-- ==============================
require('nvim-treesitter.configs').setup {
  -- 安裝的語言解析器列表，或 "all"
  ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "go", "rust", "html", "css", 'c', 'php' },

  -- 同步安裝解析器（僅適用於 ensure_installed）
  sync_install = false,

  -- 自動安裝缺少的解析器
  auto_install = false,

  -- 啟用語法高亮
  highlight = {
    enable = true,

    -- 禁用特定語言的 treesitter 高亮（使用 vim 的正則表達式高亮）
    -- disable = { "c", "rust" },

    -- 對於大文件禁用高亮
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- 額外的 vim 正則表達式高亮
    additional_vim_regex_highlighting = false,
  },

  -- 啟用增量選擇
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  -- 啟用基於 treesitter 的縮進
  indent = {
    enable = true
  },
}

-- ==============================
-- nvim-treesitter-context 設定
-- ==============================
require('treesitter-context').setup {
  enable = true, -- 啟用插件
  max_lines = 0, -- 上下文最大行數（0 表示無限制）
  min_window_height = 0, -- 最小視窗高度
  line_numbers = true, -- 顯示行號
  multiline_threshold = 20, -- 多行上下文的閾值
  trim_scope = 'outer', -- 修剪範圍: 'outer' 或 'inner'
  mode = 'cursor', -- 模式: 'cursor' 或 'topline'
  separator = nil, -- 分隔符（nil 表示使用預設）
  zindex = 20, -- 層級
  on_attach = nil, -- 附加時的回調函數
}

-- Treesitter Context 快捷鍵
vim.keymap.set('n', '<leader>tc', ':TSContextToggle<CR>', { noremap = true, silent = true, desc = '切換 Treesitter Context' })
vim.keymap.set('n', '[c', function()
  require('treesitter-context').go_to_context()
end, { noremap = true, silent = true, desc = '跳轉到上下文' })

-- ==============================
-- nvim-navic 設定（Breadcrumbs）- 必須在 LSP 之前配置
-- ==============================
local navic = require("nvim-navic")

-- 根據環境選擇圖標
local navic_icons = vim.g.use_nerd_fonts and {
  File          = "󰈙 ",
  Module        = " ",
  Namespace     = "󰌗 ",
  Package       = " ",
  Class         = "󰌗 ",
  Method        = "󰆧 ",
  Property      = " ",
  Field         = " ",
  Constructor   = " ",
  Enum          = "󰕘 ",
  Interface     = "󰕘 ",
  Function      = "󰊕 ",
  Variable      = "󰆧 ",
  Constant      = "󰏿 ",
  String        = "󰀬 ",
  Number        = "󰎠 ",
  Boolean       = "◩ ",
  Array         = "󰅪 ",
  Object        = "󰅩 ",
  Key           = "󰌋 ",
  Null          = "󰟢 ",
  EnumMember    = " ",
  Struct        = "󰌗 ",
  Event         = " ",
  Operator      = "󰆕 ",
  TypeParameter = "󰊄 ",
} or {
  File          = "Fi ",
  Module        = "Md ",
  Namespace     = "NS ",
  Package       = "Pk ",
  Class         = "Cl ",
  Method        = "M ",
  Property      = "P ",
  Field         = "Fd ",
  Constructor   = "C ",
  Enum          = "E ",
  Interface     = "I ",
  Function      = "F ",
  Variable      = "V ",
  Constant      = "Cs ",
  String        = "S ",
  Number        = "N ",
  Boolean       = "B ",
  Array         = "A ",
  Object        = "O ",
  Key           = "K ",
  Null          = "Nl ",
  EnumMember    = "EM ",
  Struct        = "St ",
  Event         = "Ev ",
  Operator      = "Op ",
  TypeParameter = "TP ",
}

navic.setup {
  icons = navic_icons,
  lsp = {
    auto_attach = false,  -- 改為手動 attach，避免衝突
    preference = nil,
  },
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true,
  lazy_update_context = false,
  click = false
}

-- ==============================
-- Mason 設定（LSP 安裝管理器）
-- ==============================
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    border = "rounded",
  }
})

-- ==============================
-- LSP 配置
-- ==============================
-- 設定 LSP 的通用能力（用於補全）
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- LSP attach 時的通用配置
local on_attach = function(client, bufnr)
  -- 整合 navic（breadcrumbs）
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- LSP 快捷鍵（僅在有 LSP 的 buffer 中生效）
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- 跳轉
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: 跳轉到定義' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'LSP: 跳轉到聲明' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'LSP: 跳轉到實現' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: 查找引用' }))
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'LSP: 類型定義' }))

  -- 文檔和提示
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: 顯示懸停文檔' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: 顯示簽名幫助' }))

  -- 代碼操作
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP: 重命名' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP: 代碼操作' }))
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', opts, { desc = 'LSP: 格式化代碼' }))

  -- 診斷
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'LSP: 上一個診斷' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'LSP: 下一個診斷' }))
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'LSP: 顯示診斷' }))
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'LSP: 診斷列表' }))
end

-- ==============================
-- Mason-LSPConfig 設定
-- ==============================
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
  mason_lspconfig.setup({
    -- 自動安裝這些 LSP 伺服器
    ensure_installed = {
      "lua_ls",          -- Lua
      "ts_ls",           -- TypeScript/JavaScript
      "pyright",         -- Python
      "gopls",           -- Go
      "rust_analyzer",   -- Rust
      "clangd",          -- C/C++
      "html",            -- HTML
      "cssls",           -- CSS
      "jsonls",          -- JSON
      "intelephense",    -- PHP
    },
    automatic_installation = true,
  })
end

-- 配置各個 LSP 伺服器（使用新的 vim.lsp.config 或舊的 lspconfig）
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  },
  ts_ls = {},
  pyright = {},
  gopls = {},
  rust_analyzer = {},
  clangd = {},
  html = {},
  cssls = {},
  jsonls = {},
  intelephense = {},
}

-- 使用新的 API (Neovim 0.11+) 或回退到舊的 lspconfig
if vim.lsp.config then
  -- 使用新的 vim.lsp.config API
  for server_name, server_config in pairs(servers) do
    pcall(function()
      vim.lsp.config(server_name, vim.tbl_deep_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
      }, server_config))
      vim.lsp.enable(server_name)
    end)
  end
else
  -- 回退到舊的 lspconfig（帶警告抑制）
  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if lspconfig_ok then
    for server_name, server_config in pairs(servers) do
      pcall(function()
        lspconfig[server_name].setup(vim.tbl_deep_extend('force', {
          on_attach = on_attach,
          capabilities = capabilities,
        }, server_config))
      end)
    end
  end
end

-- 診斷符號設定
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 診斷配置
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Lua:
-- For dark theme (neovim's default)
vim.o.background = 'dark'
-- -- For light theme
-- vim.o.background = 'light'

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Alternatively set style in setup
    -- style = 'light'

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Enable italic inlay type hints
    italic_inlayhints = true,

    -- Underline `@markup.link.*` variants
    underline_links = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Apply theme colors to terminal
    terminal_colors = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})
-- require('vscode').load()

-- load the theme without affecting devicon colors.
-- vim.cmd.colorscheme "vscode"
vim.cmd.colorscheme "tokyonight"

-- ==============================
-- 自訂顏色設定（必須在主題載入後）
-- ==============================
-- 設定空白字符的顏色（使用 Lua API 更可靠）
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#3E4451', ctermfg = 'DarkGray' })
vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#3E4451', ctermfg = 'DarkGray' })
vim.api.nvim_set_hl(0, 'NonText', { fg = '#3E4451', ctermfg = 'DarkGray' })

-- ==============================
-- nvim-cmp 自動補全設定
-- ==============================
local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')

if cmp_ok and luasnip_ok then
  cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),

  formatting = {
    format = function(entry, vim_item)
      -- 根據環境選擇圖標
      local icons = vim.g.use_nerd_fonts and {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      } or {
        Text = "T",
        Method = "M",
        Function = "F",
        Constructor = "C",
        Field = "Fd",
        Variable = "V",
        Class = "Cl",
        Interface = "I",
        Module = "Md",
        Property = "P",
        Unit = "U",
        Value = "Val",
        Enum = "E",
        Keyword = "K",
        Snippet = "S",
        Color = "Col",
        File = "Fi",
        Reference = "R",
        Folder = "Fo",
        EnumMember = "EM",
        Constant = "Cs",
        Struct = "St",
        Event = "Ev",
        Operator = "Op",
        TypeParameter = "TP",
      }
      vim_item.kind = string.format('%s %s', icons[vim_item.kind] or '', vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
})

-- 命令列補全
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
  })
else
  vim.notify("nvim-cmp or LuaSnip not installed, please run :PlugInstall", vim.log.levels.WARN)
end

-- ==============================
-- aerial.nvim 設定（代碼大綱）
-- ==============================
require('aerial').setup({
  -- 優先使用 treesitter，如果不支持則使用 LSP
  backends = { "treesitter", "lsp", "markdown", "man" },

  layout = {
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 20,
    win_opts = {},
    default_direction = "prefer_right",
    placement = "window",
  },

  attach_mode = "window",
  close_automatic_events = {},
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },

  lazy_load = true,
  disable_max_lines = 10000,
  disable_max_size = 2000000, -- 2MB

  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },

  highlight_mode = "split_width",
  highlight_closest = true,
  highlight_on_hover = false,
  highlight_on_jump = 300,

  icons = {},

  ignore = {
    unlisted_buffers = true,
    filetypes = {},
    buftypes = "special",
    wintypes = "special",
  },

  manage_folds = false,
  link_folds_to_tree = false,
  link_tree_to_folds = true,

  nerd_font = "auto",

  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,

  open_automatic = false,
  post_jump_cmd = "normal! zz",
  close_on_select = false,
  update_events = "TextChanged,InsertLeave",

  show_guides = true,
  guides = {
    mid_item   = "├─",
    last_item  = "└─",
    nested_top = "│ ",
    whitespace = "  ",
  },

  float = {
    border = "rounded",
    relative = "cursor",
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },

    override = function(conf, source_winid)
      return conf
    end,
  },

  treesitter = {
    update_delay = 300,
  },

  markdown = {
    update_delay = 300,
  },

  man = {
    update_delay = 300,
  },
})

-- Aerial 快捷鍵
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "開關代碼大綱 (Aerial)" })

-- Mason 快捷鍵
vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "開啟 Mason（LSP 管理）" })

-- ==============================
-- lualine 設定（Powerline 風格）
-- ==============================
-- 根據環境選擇分隔符
local lualine_separators = vim.g.use_nerd_fonts
  and { component = { left = '', right = '' }, section = { left = '', right = '' } }
  or { component = { left = '|', right = '|' }, section = { left = '', right = '' } }

require('lualine').setup {
  options = {
    icons_enabled = vim.g.use_nerd_fonts,
    theme = 'tokyonight',  -- 使用 tokyonight 主題
    component_separators = lualine_separators.component,  -- 分隔符
    section_separators = lualine_separators.section,  -- 分隔符
    disabled_filetypes = {
      statusline = { 'neo-tree' },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,  -- 全局狀態列
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    -- 左側：模式、Git 分支、diff、診斷信息
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'branch',
        icon = vim.g.use_nerd_fonts and '' or 'git',
      },
      {
        'diff',
        symbols = { added = '+', modified = '~', removed = '-' },
        colored = true,
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,  -- 相對路徑
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[RO]',
          unnamed = '[No Name]',
        }
      }
    },
    -- 右側：診斷、編碼、檔案類型、位置
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
        colored = true,
      },
      'encoding',
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        }
      },
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
      }
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    }
  },
  inactive_winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    }
  },
  extensions = { 'neo-tree', 'fugitive', 'aerial' }
}

-- ==============================
-- better_whitespace 設定
-- ==============================
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

-- ==============================
-- nvim-web-devicons 設定（控制文件圖標）
-- ==============================
if not vim.g.use_nerd_fonts then
  -- 在 SSH 環境下，覆蓋 nvim-web-devicons 使其返回空圖標
  require('nvim-web-devicons').setup({
    override = {},
    default = true,
    override_by_filename = {},
    override_by_extension = {},
  })

  -- 完全禁用圖標顯示
  local devicons = require('nvim-web-devicons')
  local original_get_icon = devicons.get_icon
  devicons.get_icon = function(...)
    return "", ""  -- 返回空字符串和空高亮
  end
  devicons.get_icon_by_filetype = function(...)
    return "", ""
  end
end

-- ==============================
-- nvim-window-picker 設定
-- ==============================
require('window-picker').setup({
  hint = 'floating-big-letter',
  selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  filter_rules = {
    autoselect_one = true,
    include_current_win = false,
    bo = {
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      buftype = { 'terminal', 'quickfix' },
    },
  },
})

-- ==============================
-- Neo-tree 設定
-- ==============================
-- 根據環境選擇 Neo-tree 圖標
local neotree_icon_config = vim.g.use_nerd_fonts and {
  folder_closed = "",
  folder_open = "",
  folder_empty = "󰜌",
  default = "",
} or {
  folder_closed = "[+]",
  folder_open = "[-]",
  folder_empty = "[ ]",
  default = "",
}

require("neo-tree").setup({
  close_if_last_window = false, -- 當 Neo-tree 是最後一個窗口時不自動關閉
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  enable_refresh_on_write = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = vim.g.use_nerd_fonts and "│" or "|",
      last_indent_marker = vim.g.use_nerd_fonts and "└" or "\\",
      highlight = "NeoTreeIndentMarker",
    },
    icon = neotree_icon_config,
    modified = {
      symbol = vim.g.use_nerd_fonts and "" or "+",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = "+",
        modified  = "~",
        deleted   = "-",
        renamed   = vim.g.use_nerd_fonts and "➜" or "R",
        untracked = "?",
        ignored   = "!",
        unstaged  = vim.g.use_nerd_fonts and "✗" or "U",
        staged    = vim.g.use_nerd_fonts and "✓" or "S",
        conflict  = vim.g.use_nerd_fonts and "" or "C",
      }
    },
  },
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
          "toggle_node",
          nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["o"] = "open",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "none"
        }
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    }
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        "node_modules"
      },
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    -- 在 SSH 環境下使用簡化的組件列表
    components = not vim.g.use_nerd_fonts and {
      icon = function(config, node, state)
        local icon = " "
        if node.type == "directory" then
          if node:is_expanded() then
            icon = "[-]"
          else
            icon = "[+]"
          end
        else
          icon = "   "  -- 文件前綴空格
        end
        return {
          text = icon,
          highlight = config.highlight or "NeoTreeFileIcon",
        }
      end,
    } or nil,
  },
})

-- Neo-tree 快捷鍵
vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = '開關 Neo-tree' })
vim.keymap.set('n', '<leader>e', ':Neotree focus<CR>', { noremap = true, silent = true, desc = '聚焦 Neo-tree' })

-- ==============================
-- Bufferline 設定
-- ==============================
require('bufferline').setup({
  options = {
    mode = "buffers",
    style_preset = require('bufferline').style_preset.default,
    themable = true,
    numbers = "none",
    close_command = "Bdelete! %d",  -- 使用 Bdelete 保持視窗佈局
    right_mouse_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,

    -- 指示器設定
    indicator = {
      icon = '▎',
      style = 'icon',
    },

    -- 圖標設定（簡化以支持 SSH/Guacamole）
    buffer_close_icon = 'x',
    modified_icon = '+',
    close_icon = 'X',
    left_trunc_marker = '<',
    right_trunc_marker = '>',

    -- 長度設定
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 20,

    -- 診斷設定
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_update_on_event = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and "" or ""
      return " " .. icon .. " " .. count
    end,

    -- Neo-tree 偏移設定
    offsets = {
      {
        filetype = "neo-tree",
        text = " 檔案瀏覽器",
        text_align = "center",
        separator = true,
      }
    },

    -- 視覺設定
    color_icons = vim.g.use_nerd_fonts,
    get_element_icon = function(element)
      if vim.g.use_nerd_fonts then
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end
      return nil, nil
    end,
    show_buffer_icons = vim.g.use_nerd_fonts,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    duplicates_across_groups = true,
    persist_buffer_sort = true,
    move_wraps_at_ends = false,

    -- 分隔符樣式（圓角效果）
    separator_style = { '', '' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    auto_toggle_bufferline = true,

    -- 懸停設定
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },

    -- 排序
    sort_by = 'insert_after_current',
  },
})

-- 創建命令別名，讓 :bd 使用 Bdelete（保持視窗佈局）
vim.cmd([[
  command! -bang -complete=buffer -nargs=? Bd Bdelete<bang> <args>
  cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>
]])

-- Bufferline 快捷鍵
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = '下一個 buffer' })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = '上一個 buffer' })
vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { noremap = true, silent = true, desc = '關閉當前 buffer' })
vim.keymap.set('n', '<leader>bD', ':Bdelete!<CR>', { noremap = true, silent = true, desc = '強制關閉當前 buffer' })
vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true, desc = '關閉左側所有 buffer' })
vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { noremap = true, silent = true, desc = '關閉右側所有 buffer' })
vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true, desc = '關閉其他 buffer' })
vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { noremap = true, silent = true, desc = '選擇 buffer' })
vim.keymap.set('n', '<leader>bP', ':BufferLineTogglePin<CR>', { noremap = true, silent = true, desc = '釘選/取消釘選 buffer' })

-- 使用 Alt+數字 快速跳轉到指定 buffer
vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLineGoToBuffer -1<CR>', { noremap = true, silent = true })

-- 使用 Alt+< 和 Alt+> 移動 buffer 位置
vim.keymap.set('n', '<A-<>', ':BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = '向左移動 buffer' })
vim.keymap.set('n', '<A->>', ':BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = '向右移動 buffer' })

-- ==============================
-- Telescope 設定
-- ==============================
local telescope = require('telescope')
telescope.setup({
  defaults = {
    -- 預設設定
    prompt_prefix = vim.g.use_nerd_fonts and "🔍 " or "> ",
    selection_caret = vim.g.use_nerd_fonts and " " or "> ",
    path_display = { "truncate" },
    file_ignore_patterns = { "node_modules", ".git/", "%.jpg", "%.png" },

    -- 視窗配置
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    mappings = {
      i = {
        -- Insert 模式下的快捷鍵（改用 Alt 避免與瀏覽器衝突）
        ["<A-j>"] = "move_selection_next",
        ["<A-k>"] = "move_selection_previous",
        ["<A-q>"] = "send_to_qflist",
        ["<esc>"] = "close",
      },
      n = {
        -- Normal 模式下的快捷鍵
        ["<A-j>"] = "move_selection_next",
        ["<A-k>"] = "move_selection_previous",
        ["q"] = "close",
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      hidden = true,  -- 顯示隱藏檔案
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }  -- 搜尋隱藏檔案
      end
    },
  },
})

-- 載入 fzf 擴展 (提升搜尋速度)
pcall(telescope.load_extension, 'fzf')

-- ==============================
-- Telescope 快捷鍵
-- ==============================
local builtin = require('telescope.builtin')

-- 檔案搜尋 (類似 VSCode Ctrl+P)
vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = 'Telescope: 搜尋檔案' })

-- 全域關鍵字搜尋 (類似 VSCode Ctrl+Shift+F)
vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope: 全域搜尋' })

-- 搜尋目前開啟的 buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: 搜尋 Buffers' })

-- 搜尋 Git 檔案 (只搜尋 Git 追蹤的檔案)
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope: 搜尋 Git 檔案' })

-- 搜尋目前檔案內的內容
vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'Telescope: 搜尋目前檔案' })

-- 搜尋命令歷史
vim.keymap.set('n', '<leader>fh', builtin.command_history, { desc = 'Telescope: 命令歷史' })

-- 搜尋幫助文檔
vim.keymap.set('n', '<leader>fH', builtin.help_tags, { desc = 'Telescope: 幫助文檔' })

-- 搜尋最近開啟的檔案
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope: 最近檔案' })

-- 搜尋 Git commits
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope: Git Commits' })

-- 搜尋 Git status (查看變更的檔案)
vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = 'Telescope: Git Status' })

-- ==============================
-- 視窗操作快捷鍵（將 Ctrl+w 改為 Alt+w）
-- ==============================
vim.keymap.set('n', '<A-w>h', '<C-w>h', { noremap = true, silent = true, desc = '切換到左邊視窗' })
vim.keymap.set('n', '<A-w>j', '<C-w>j', { noremap = true, silent = true, desc = '切換到下方視窗' })
vim.keymap.set('n', '<A-w>k', '<C-w>k', { noremap = true, silent = true, desc = '切換到上方視窗' })
vim.keymap.set('n', '<A-w>l', '<C-w>l', { noremap = true, silent = true, desc = '切換到右邊視窗' })
vim.keymap.set('n', '<A-w>w', '<C-w>w', { noremap = true, silent = true, desc = '切換到下一個視窗' })
vim.keymap.set('n', '<A-w>s', '<C-w>s', { noremap = true, silent = true, desc = '水平分割視窗' })
vim.keymap.set('n', '<A-w>v', '<C-w>v', { noremap = true, silent = true, desc = '垂直分割視窗' })
vim.keymap.set('n', '<A-w>q', '<C-w>q', { noremap = true, silent = true, desc = '關閉視窗' })
vim.keymap.set('n', '<A-w>=', '<C-w>=', { noremap = true, silent = true, desc = '平均分配視窗大小' })
vim.keymap.set('n', '<A-w>o', '<C-w>o', { noremap = true, silent = true, desc = '關閉其他視窗' })

-- ==============================
-- 拼寫檢查快捷鍵
-- ==============================
-- 切換拼寫檢查
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', { noremap = true, silent = true, desc = '切換拼寫檢查' })

-- 拼寫檢查導航
vim.keymap.set('n', ']s', ']s', { noremap = true, silent = true, desc = '下一個拼寫錯誤' })
vim.keymap.set('n', '[s', '[s', { noremap = true, silent = true, desc = '上一個拼寫錯誤' })

-- 拼寫建議
vim.keymap.set('n', 'z=', 'z=', { noremap = true, silent = true, desc = '顯示拼寫建議' })
vim.keymap.set('n', 'zg', 'zg', { noremap = true, silent = true, desc = '加入正確單字' })
vim.keymap.set('n', 'zw', 'zw', { noremap = true, silent = true, desc = '標記為錯誤單字' })
vim.keymap.set('n', 'zug', 'zug', { noremap = true, silent = true, desc = '撤銷加入單字' })

-- ==============================
-- ToggleTerm 終端機設定
-- ==============================
require('toggleterm').setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<leader>t]],  -- 空白+t 開關終端機
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',  -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',  -- 'single' | 'double' | 'shadow' | 'curved'
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  },
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return term.name
    end
  },
})

-- ToggleTerm 快捷鍵
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)  -- Esc 退出終端模式
  -- 改用 Alt 鍵避免與瀏覽器衝突（終端模式下 leader 鍵較難使用）
  vim.keymap.set('t', '<A-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<A-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<A-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<A-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<A-w>', [[<C-\><C-n><A-w>]], opts)  -- Alt+w 作為視窗操作前綴
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- 不同方向的終端機快捷鍵
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = '浮動終端機' })
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true, desc = '水平分割終端機' })
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true, desc = '垂直分割終端機' })

-- 快速執行命令的函數
vim.keymap.set('n', '<leader>gg', ':lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'LazyGit' })

-- LazyGit 整合（如果安裝了 lazygit）
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end
