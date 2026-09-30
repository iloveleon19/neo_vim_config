# Neovim 原生外掛

使用 Neovim 0.11.x 的 `pack/*/start/` 自動載入外掛，不需要 `init.lua`、
vim-plug 或 `vim.pack`。每個外掛的額外設定放在 `after/plugin/外掛名稱.lua`。

## 安裝與搬移

```bash
sudo apt install git curl build-essential ripgrep unzip nodejs npm python3 golang rustup
rustup default stable
cd ~/neo_vim_config
python3 scripts/plugins.py install
nvim
```

第一次開啟 Neovim 時，Mason 會在背景安裝 LSP 伺服器（見下方「LSP」）。
`golang` 用來編譯 gopls；`rustup` 提供 rust-analyzer 需要的 cargo。

已安裝外掛、只想搬移舊 `opt/` 結構時：

```bash
python3 scripts/plugins.py migrate
```

腳本將清單中的外掛從 `opt/` 搬到 `start/`，保留原版本、編譯結果及本地修改；
不在清單內的外掛留在 `opt/`，不會自動載入。
腳本會連結 `~/.config/nvim/after` 到本專案 `after/`，並移除先前指向本專案
`init.lua` 的連結。遇到其他既有設定或重複目錄會停止，不會覆蓋它們。
資料與設定位置由 Neovim 決定，支援 `XDG_DATA_HOME`、`XDG_CONFIG_HOME`、
`NVIM_APPNAME`。安裝與更新需要網路，僅搬移不需要網路。

## 目錄

```text
~/.local/share/nvim/site/pack/neo_vim_config/start/  # 外掛程式
~/.config/nvim/after -> ~/neo_vim_config/after      # 額外設定

neo_vim_config/
├── plugins.json
├── after/plugin/     # 每個外掛一個設定檔，見下方「外掛設定」
├── scripts/
└── backups/
```

要設定某個外掛，就新增它的 Lua 檔；Neovim 會在載入外掛後自動執行。
例如 `after/plugin/lualine.lua`：

```lua
require('lualine').setup()
```

需要 `setup()` 的外掛不會因為已安裝就啟用全部功能。
這些設定檔依檔名順序載入；如果設定之間有先後依賴，可用 `10-mason.lua`、
`20-mason-lspconfig.lua` 排序，或在同一檔內明確處理。
不要再將舊的 `init.lua` 備份連回設定目錄。

## 外掛設定

原則：盡量使用外掛預設值，只覆蓋必要的選項。

| 檔案 | 內容 |
|---|---|
| `options.lua` | Neovim 本身的選項：行號、顯示空白字元、關閉 showmode。使用 `<leader>` 的按鍵要寫在這個檔案 |
| `neo-tree.lua` | 圖示換成 ASCII（資料夾 `+`/`-`，git 狀態 `M`、`A`、`?` 等） |
| `lualine.lua` | 關閉圖示、全域狀態列、頂端 winbar 顯示 nvim-navic 位置 |
| `bufferline.lua` | 關閉按鈕與截斷符號換成 ASCII |
| `nvim-navic.lua` | 符號類型用文字縮寫，LSP 連上時自動啟用 |
| `nvim-treesitter.lua` | 開啟語法高亮 |
| `telescope.lua` | 載入 fzf-native 加速 |
| `aerial.lua`、`toggleterm.lua` | 預設 `setup()` |
| `mason.lua` | mason、mason-lspconfig 與自動安裝的 LSP 清單 |
| `lazydev.lua` | 讓 lua_ls 認得 Neovim API（寫 Neovim 設定時有 `vim.*` 補全） |
| `nvim-cmp.lua` | 補全來源、外框、來源標示、`/` 與 `:` 補全、LSP 補全能力 |
| `LuaSnip.lua` | 載入 friendly-snippets、`Tab` 跳片段欄位 |

### 不使用 Nerd Font

設定不依賴 Nerd Font，任何終端機字型都能正常顯示。沒有安裝
`nvim-web-devicons`，telescope、aerial 會自動改用純文字。
新增外掛時注意它的預設圖示；多數外掛可用 `icons_enabled = false` 或
覆蓋圖示選項改成一般字元。

### LSP

`mason.lua` 的 `ensure_installed` 列出開啟 Neovim 時自動安裝的伺服器：
lua_ls、ts_ls、pyright、gopls、rust_analyzer、clangd、html、cssls、jsonls、
intelephense、marksman（Markdown）、cspell_ls（拼字檢查）。
其他語言可用 `:Mason` 或 `:LspInstall <名稱>` 安裝，mason-lspconfig 會自動啟用。

### 按鍵

目前只設定補全與片段的按鍵，其餘使用 Neovim 0.11 預設。

| 按鍵（插入模式） | 功能 |
|---|---|
| `Ctrl+n` / `Ctrl+p`、`↓` / `↑` | 補全選單選擇；選單未開時叫出選單 |
| `Ctrl+y` / `Ctrl+e` | 確認 / 關閉補全 |
| `Tab` / `Shift+Tab` | 片段內跳下一個 / 上一個欄位，否則照常輸入 |

LSP 使用 Neovim 預設：`K` 說明、`grn` 重新命名、`gra` code action、
`grr` 找引用、`gri` 跳到實作、`[d` / `]d` 上一個 / 下一個診斷。

## 維護與使用

- 安裝缺少的外掛／重試編譯：`python3 scripts/plugins.py install`。
- 更新：`python3 scripts/plugins.py update`，完成後重開 Neovim。
- 清單：`plugins.json`。`branch` 指定分支，`tag` 固定版本，`release: true`
  選最新穩定標籤；未指定則使用遠端預設分支。
- 移除外掛時，除了刪掉清單項目，還需將其目錄移出 `start/` 並移除對應設定；
  只改清單不會讓已在 `start/` 的外掛停止載入。腳本不自動刪除外掛。
- 檢查環境：`:checkhealth`；可試用 `:Git`、`:Telescope find_files`、`:Neotree`、
  `:AerialToggle`、`:ToggleTerm`、`:Mason`。
- LazyGit 是獨立程式，可在終端機執行 `lazygit` 或使用 `:terminal lazygit`。

安裝／更新會編譯 telescope-fzf-native，並安裝 `scripts/post-install.lua` 語言清單的
Treesitter parsers；`nvim-treesitter.lua` 只開啟高亮，未開啟縮排。
Treesitter 保留 `master`，Aerial 保留 `nvim-0.11`，Telescope 保留 `0.1.8`，
Neo-tree 保留 `v3.x`，以維持目前相容性；其餘外掛未來仍可能提高版本需求。
更新遇到本地修改或非快轉歷史會停止。此腳本沒有 lockfile 或更新預覽介面。

修改後請完整退出並重開 Neovim，舊映射不會因重新 source 就消失。
舊設定備份在 `backups/`，都不會自動載入：`init-v3-a6e81a7.lua` 是 vim-plug 時期最完整的
Lua 設定（commit a6e81a7），`init-backup.vim` 是更早的 Vimscript 版本。
原生套件及載入順序請參閱 `:help packages`、`:help load-plugins`。
