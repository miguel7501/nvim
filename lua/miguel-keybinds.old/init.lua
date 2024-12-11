-- make sure leader is also set directly in init.lua
vim.g.mapleader = 's'
vim.g.maplocalleader = 's'
vim.keymap.set('n', 'S', 's', {})
--
-- LSP keybinds (stolen from lsp-zero)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

-- my own LSP keybinds
vim.keymap.set('n', '<C-K>', '<cmd>lua vim.diagnostic.open_float()<cr>')


-- Theming
vim.cmd("syntax enable")
vim.cmd("colorscheme shades_of_purple")
vim.g.shades_of_purple_airline = 1
vim.g.airline_theme = "shades_of_purple"
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FF9D00" })
vim.api.nvim_set_hl(0, "Function", { fg = "#FAD000" })

-- :python
vim.g.python3_host_prog = '/home/miguel/scripts/python/.venv/bin/python3'

-- undotree
vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)
