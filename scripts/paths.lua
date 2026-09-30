io.stdout:write(vim.json.encode({
  data = vim.fn.stdpath('data'),
  config = vim.fn.stdpath('config'),
}))
