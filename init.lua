if not vim.g.vscode then
    vim.g.mapleader = 's'
    vim.g.maplocalleader = 's'
    ---@type boolean
    Sad = vim.system({"which", "wslview"}):wait().code == 0
    require("miguel.settings")
    require("miguel.lazy")
    require("miguel.lsp")
    require("miguel.keymaps")
    require("miguel.after")
else
    require("miguel-vscode")
end

