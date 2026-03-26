if not vim.g.vscode then
    vim.g.mapleader = 's'
    vim.g.maplocalleader = 's'
    ---@type boolean
    Sad = vim.fn.has("wsl") == 1
    require("miguel.settings")
    require("miguel.lazy")
    require("miguel.lsp")
    require("miguel.keymaps")
    require("miguel.after")
else
    require("miguel-vscode")
end

