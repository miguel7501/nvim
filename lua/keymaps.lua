-- plugin keymaps go into the plugin files.
-- This file is for general keymaps

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-c>', '<Esc>') -- without this, diagnostics sometimes stay hidden after exiting insert mode

local functions = require("functions")

-- LSP Stuff
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)

vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end)
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set({ 'n', 'i' }, '<F2>', function() vim.lsp.buf.rename() end)
vim.keymap.set({'n','i','v'}, '<F4>', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<C-K>',function() vim.diagnostic.open_float({border="solid"}) end)
vim.keymap.set('n', '<M-r>', '<C-w>h')
vim.keymap.set('n', '<M-s>', '<C-w>j')
vim.keymap.set('n', '<M-t>', '<C-w>l')
vim.keymap.set('n', '<M-f>', '<C-w>k')
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, {desc = 'Toggle diagnostics using vim.diagnostic.enable()'})
vim.keymap.set('n', '<leader>Q',function () print("vim.diagnostic.is_enabled() -> "..tostring(vim.diagnostic.is_enabled()))end, {desc = 'Check if diagnostics are enabled'})
vim.keymap.set({'n','v'}, '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>lR', ":LspRestart<CR>")
vim.keymap.set('n', '<leader>lI', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {desc="Toggle inlay hints"})
vim.keymap.set('n', '<leader>li', functions.apply_inlay_hint, { desc = "Apply inlay hint after cursor" })

-- more LSP stuff in ./plugins/trouble.lua

-- debug keymaps are in ./plugins/dap.lua
-- gitsigns keymaps are in ./plugins/git.lua
-- harpoon keymaps are in ./plugins/harpoon.lua



-- Terminal stuff
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.keymap.set('n', 'gF', functions.gf, { buffer = 0, noremap = true })
        vim.keymap.set('n', 'gf', functions.gf, { buffer = 0, noremap = true })
    end
})
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {desc="Exit insert mode in terminal"})
vim.api.nvim_create_user_command('VT', functions.vt, {desc="Open a terminal in a vertical split, reusing an existing one if possible"})
vim.api.nvim_create_user_command('Vt', functions.vt, {desc="Open a terminal in a vertical split, reusing an existing one if possible"})
vim.api.nvim_create_user_command('Term', functions.term, {desc="Open a terminal, reusing an existing one if possible"})


-- Letting go of shift is hard
vim.api.nvim_create_user_command("W", 'w', { bang = true})
vim.api.nvim_create_user_command("Q", 'q', { bang = true})
vim.api.nvim_create_user_command("WQ", 'wq', { bang = true})
vim.api.nvim_create_user_command("Wq", 'wq', { bang = true})

