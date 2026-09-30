-- 不用 Nerd Font：關閉圖示，分隔符號改成一般字元。
local navic = require('nvim-navic')

require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    globalstatus = true,  -- 整個畫面只有一條狀態列
  },
  -- 視窗頂端顯示 nvim-navic 的所在位置（需要 LSP）
  winbar = {
    lualine_c = { { navic.get_location, cond = navic.is_available } },
  },
}
