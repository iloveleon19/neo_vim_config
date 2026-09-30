-- 不用 Nerd Font：只覆蓋預設值裡的圖示字元。
require('neo-tree').setup({
  default_component_configs = {
    icon = {
      folder_closed = '+', folder_open = '-',
      folder_empty = '+', folder_empty_open = '-',
      selected = '*', default = ' ',
    },
    git_status = {
      symbols = {
        added = 'A', deleted = 'D', modified = 'M', renamed = 'R',
        untracked = '?', ignored = 'I', unstaged = 'U', staged = 'S',
        conflict = '!',
      },
    },
  },
})
