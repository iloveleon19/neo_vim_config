-- 不用 Nerd Font：只覆蓋預設值裡的圖示字元。
require('bufferline').setup({
  options = {
    buffer_close_icon = 'x',
    close_icon = 'X',
    left_trunc_marker = '<',
    right_trunc_marker = '>',
  },
})
