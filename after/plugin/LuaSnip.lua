local luasnip = require('luasnip')

-- 載入 friendly-snippets 等 VS Code 格式的片段
require('luasnip.loaders.from_vscode').lazy_load()

-- 與 Neovim 內建片段相同：在片段裡 Tab/Shift+Tab 跳欄位，否則照常輸入
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
  return luasnip.locally_jumpable(1) and '<Cmd>lua require("luasnip").jump(1)<CR>' or '<Tab>'
end, { expr = true, desc = 'LuaSnip: 下一個欄位' })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  return luasnip.locally_jumpable(-1) and '<Cmd>lua require("luasnip").jump(-1)<CR>' or '<S-Tab>'
end, { expr = true, desc = 'LuaSnip: 上一個欄位' })
