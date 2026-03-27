---@type boolean
Sad = vim.fn.has("wsl") == 1
require("settings")
require("lazy_plugin_manager")
require("lsp")
require("autocmds")
require("keymaps")
if Sad then
    require("wsl")
end

vim.cmd[[colorscheme shades_of_purple]]
