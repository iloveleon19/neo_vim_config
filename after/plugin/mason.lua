-- mason 必須先於 mason-lspconfig 設定。
require('mason').setup()
require('mason-lspconfig').setup({
  -- 開啟 Neovim 時自動安裝缺少的 LSP 伺服器
  ensure_installed = {
    'lua_ls',         -- Lua
    'ts_ls',          -- TypeScript/JavaScript
    'pyright',        -- Python
    'gopls',          -- Go
    'rust_analyzer',  -- Rust
    'clangd',         -- C/C++
    'html',           -- HTML
    'cssls',          -- CSS
    'jsonls',         -- JSON
    'intelephense',   -- PHP
    'marksman',       -- Markdown
    'cspell_ls',      -- 拼字檢查（VS Code Code Spell Checker 的 cspell）
  },
})
