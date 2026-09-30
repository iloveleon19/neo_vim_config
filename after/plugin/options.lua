-- Neovim 本身的選項與按鍵。
-- 使用 <leader> 的按鍵請寫在本檔 mapleader 之後，其他設定檔依檔名順序載入。

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { space = '.', tab = '>-', trail = '.' }
vim.opt.showmode = false  -- lualine 已顯示模式
