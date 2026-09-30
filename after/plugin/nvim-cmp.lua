local cmp = require('cmp')
local luasnip = require('luasnip')

-- 類型縮寫，沒有 Nerd Font 也能顯示
local kind_abbr = {
  Text = 'T', Method = 'M', Function = 'F', Constructor = 'C',
  Field = 'Fd', Variable = 'V', Class = 'Cl', Interface = 'I',
  Module = 'Md', Property = 'P', Unit = 'U', Value = 'Val',
  Enum = 'E', Keyword = 'K', Snippet = 'S', Color = 'Col',
  File = 'Fi', Reference = 'R', Folder = 'Fo', EnumMember = 'EM',
  Constant = 'Cs', Struct = 'St', Event = 'Ev', Operator = 'Op',
  TypeParameter = 'TP',
}

local source_label = {
  nvim_lsp = '[LSP]',
  luasnip = '[Snippet]',
  buffer = '[Buffer]',
  path = '[Path]',
}

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- Ctrl+n/Ctrl+p 或上下鍵選擇，Ctrl+y 確認，Ctrl+e 關閉
  mapping = cmp.mapping.preset.insert(),
  -- 第一組沒有結果時才使用第二組
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, item)
      item.kind = string.format('%s %s', kind_abbr[item.kind] or '', item.kind)
      item.menu = source_label[entry.source.name]
      return item
    end,
  },
})

-- / 搜尋時提示目前檔案的字
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } },
})

-- : 指令時提示路徑與指令
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

-- 讓 LSP 知道 cmp 支援的補全功能（套用到所有 LSP）
vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
