-- 不用 Nerd Font：符號類型改用文字縮寫。
require('nvim-navic').setup {
  lsp = { auto_attach = true },  -- LSP 連上時自動啟用
  icons = {
    File = 'Fi ', Module = 'Md ', Namespace = 'NS ', Package = 'Pk ',
    Class = 'Cl ', Method = 'M ', Property = 'P ', Field = 'Fd ',
    Constructor = 'C ', Enum = 'E ', Interface = 'I ', Function = 'F ',
    Variable = 'V ', Constant = 'Cs ', String = 'S ', Number = 'N ',
    Boolean = 'B ', Array = 'A ', Object = 'O ', Key = 'K ',
    Null = 'Nl ', EnumMember = 'EM ', Struct = 'St ', Event = 'Ev ',
    Operator = 'Op ', TypeParameter = 'TP ',
  },
}
