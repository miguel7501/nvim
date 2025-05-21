if not vim.g.vscode then
    vim.g.mapleader = 's'
    vim.g.maplocalleader = 's'
    -- vim.keymap.set('n', 'S', 's', {})
    require("miguel.settings")
    require("miguel.lazy")
    require("miguel.lsp")
    require("miguel.keymaps")
    require("miguel.after")
else
    require("miguel-vscode")
end

