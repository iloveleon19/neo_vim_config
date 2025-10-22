-- ===========================
-- 基本設定
-- ===========================
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

-- Telescope 模糊搜尋工具
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

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
-- lualine 設定（Powerline 風格）
-- ==============================
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',  -- 使用 tokyonight 主題
    component_separators = { left = '', right = '' },  -- Powerline 小分隔符
    section_separators = { left = '', right = '' },  -- Powerline 大分隔符
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
        icon = '',
      },
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
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
          modified = ' ●',
          readonly = ' ',
          unnamed = '[No Name]',
        }
      }
    },
    -- 右側：診斷、編碼、檔案類型、位置
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
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
  winbar = {},
  inactive_winbar = {},
  extensions = { 'neo-tree', 'fugitive' }
}

-- ==============================
-- better_whitespace 設定
-- ==============================
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

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
require("neo-tree").setup({
  close_if_last_window = false, -- 當 Neo-tree 是最後一個窗口時不自動關閉
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "*",
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "󰁕",
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
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
  },
})

-- Neo-tree 快捷鍵
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree focus<CR>', { noremap = true, silent = true })

-- ==============================
-- Bufferline 設定
-- ==============================
require('bufferline').setup({
  options = {
    mode = "buffers",
    style_preset = require('bufferline').style_preset.default,
    themable = true,
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,

    -- 指示器設定
    indicator = {
      icon = '▎',
      style = 'icon',
    },

    -- 圖標設定
    buffer_close_icon = '󰅖',
    modified_icon = '',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',

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
    color_icons = true,
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true,
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

-- Bufferline 快捷鍵
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = '下一個 buffer' })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = '上一個 buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = '關閉當前 buffer' })
vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', { noremap = true, silent = true, desc = '強制關閉當前 buffer' })
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
    prompt_prefix = "🔍 ",
    selection_caret = " ",
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
        -- Insert 模式下的快捷鍵
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-q>"] = "send_to_qflist",
        ["<esc>"] = "close",
      },
      n = {
        -- Normal 模式下的快捷鍵
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
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
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope: 搜尋檔案' })

-- 全域關鍵字搜尋 (類似 VSCode Ctrl+Shift+F)
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope: 全域搜尋' })

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
  open_mapping = [[<C-\>]],  -- Ctrl+\ 開關終端機
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
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
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
