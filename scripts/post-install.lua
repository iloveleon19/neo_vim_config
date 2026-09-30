-- Install/update parsers synchronously without loading the user's init.lua.
vim.cmd('packadd nvim-treesitter')
local languages = {
  'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'python', 'go',
  'rust', 'html', 'css', 'c', 'php',
}
require('nvim-treesitter.install').update({ with_sync = true })(languages)
-- The installer may report a compiler/download error without throwing Lua errors.
-- Do not report success if any requested parser is still missing.
for _, language in ipairs(languages) do
  assert(#vim.api.nvim_get_runtime_file('parser/' .. language .. '.so', false) > 0,
    'Parser installation failed: ' .. language .. '. Check the download/compiler output and retry.')
end
local root = vim.fn.stdpath('data') .. '/site/pack/neo_vim_config/start'
for _, doc in ipairs(vim.fn.glob(root .. '/*/doc', false, true)) do
  vim.cmd('helptags ' .. vim.fn.fnameescape(doc))
end
