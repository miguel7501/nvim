local misc = require("miguel.misc")

-- make sure leader is also set directly in the main init.lua
vim.g.mapleader = 's'
vim.g.maplocalleader = 's'
vim.keymap.set('n', 'S', 's', {})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- LSP Stuff
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- vim.keymap.set('n', 'gd', function()
--     vim.lsp.buf.definition()
--     vim.cmd('normal! zz')
-- end)
vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions toggle<cr>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>zz')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>zz')
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>zz')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>zz')
vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references toggle<cr>zz')
-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>zz')
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set({ 'n', 'i' }, '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>zz')
vim.keymap.set({ 'n', 'i' }, '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
vim.keymap.set('n', '<C-K>', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '<M-r>', '<C-w>h')
vim.keymap.set('n', '<M-s>', '<C-w>j')
vim.keymap.set('n', '<M-t>', '<C-w>l')
vim.keymap.set('n', '<M-f>', '<C-w>k')
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
vim.keymap.set('n', '<leader>la', "<cmd>lua vim.lsp.buf.code_action()<cr>")
--
-- Trouble
vim.keymap.set('n', '<leader>t', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set('n', '<leader>T', "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set('n', '<leader>T', function()
    for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
    end
    vim.cmd("Trouble diagnostics toggle")
end)
vim.keymap.set('n', '<leader>ls', "<cmd>Trouble symbols toggle<cr>")







--
-- formatting
vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
-- this gets overriden for python in ftplugin/python.lua



-- Telescope
local tsbuiltin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function()
    tsbuiltin.find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
end, {})
-- vim.keymap.set({ 'n', 'i' }, '<F37>', function() -- Ctrl Shift P, windows terminal turns that into F37
--     tsbuiltin.grep_string({ search = vim.fn.input("Search in files> "), additional_args = { "--no-config" } })
-- end)
vim.keymap.set('n', '<F37>', function()
    tsbuiltin.live_grep({ 'rg', '--no-config', '--files', '--hidden', '--no-ignore' })
end, {})
vim.keymap.set('n', '<leader>fp', tsbuiltin.lsp_workspace_symbols)

-- undotree
vim.keymap.set({ 'n', 'i' }, '<F1>', vim.cmd.UndotreeToggle)

-- debugging
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set({ 'n', 'i' }, '<F5>', dap.step_into)
vim.keymap.set({ 'n', 'i' }, '<F6>', dap.step_over)
vim.keymap.set({ 'n', 'i' }, '<F7>', dap.step_out)
vim.keymap.set({ 'n', 'i' }, '<F8>', dap.continue)
vim.keymap.set({ 'n', 'i' }, '<F32>', dap.run_last) -- Ctrl F8
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>e', dapui.eval)
-- vim.keymap.set('n', '<Leader>dr', function()
--     dap.repl.toggle({}, 'vert rightbelow split')
--     vim.cmd("normal! <C-w>l")
-- end)
vim.keymap.set('n', '<leader>dd', dap.down)
vim.keymap.set('n', '<leader>du', dap.up)
vim.keymap.set('n', '<leader>dj', dap.goto_)
vim.keymap.set('n', '<leader>dm', require("dap-python").test_method)
vim.keymap.set('n', '<F20>', dap.terminate) -- F20 is obviously the same as Shift+F8
vim.keymap.set('n', '<leader>dr', function() dapui.toggle { reset = true } end)
vim.keymap.set('n', '<leader>dvt', "<cmd>DapVirtualTextToggle<cr")



-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<C-e>", function() misc.harpoon_toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set('n', '<leader>a', function()
    print("Added buffer to harpoon"); harpoon:list():add()
end)
vim.keymap.set('n', '<leader>n', function() harpoon:list():next() end)
vim.keymap.set('n', '<leader>p', function() harpoon:list():prev() end)
vim.keymap.set('n', '<leader>r', function()
    print("removed buffer from harpoon"); harpoon:list():remove()
end)



-- Misc
vim.keymap.set('n', ',', ';.') -- use comma to repeat the last movement, then the last command. Useful for things like $p
-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
    "FileType", {
        pattern = { "qf" },
        command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
    })
vim.keymap.set('n', '<F12>', [[<cmd>MaximizerToggle<cr>]])
vim.keymap.set('n', '<leader>i', "<cmd>Inspect<cr>")
--TODO read http://www.linusakesson.net/programming/tty/
vim.keymap.set({'n', 'v'}, 'gx', misc.gx)
vim.keymap.set('n', '<leader>B', '<cmd>BlameToggle<cr>')

vim.keymap.set('t', '<esc><esc>', "<c-\\><c-n>")




-- this is getting out of hand. We need some categories for keymaps so I can remember them
-- sd* for debugging
--TODO ss for 'show' -> Undotree, blame, diagnostic virtualtext
