--TODO put the ghostty config in this repo ya dummy

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
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>zz')
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>zz')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>zz')
vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references toggle<cr>zz')
-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>zz')
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set({ 'n', 'i' }, '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>zz')
vim.keymap.set({'n','i','v'}, '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
vim.keymap.set('n', '<C-K>', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '<M-r>', '<C-w>h')
vim.keymap.set('n', '<M-s>', '<C-w>j')
vim.keymap.set('n', '<M-t>', '<C-w>l')
vim.keymap.set('n', '<M-f>', '<C-w>k')
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
vim.keymap.set({'n','v'}, '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)

--
-- formatting
vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
-- this gets overriden for python in ftplugin/python.lua



-- Telescope
local telbuiltin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function()
    telbuiltin.find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
end, {})
vim.keymap.set('n', '<F37>', function()
    telbuiltin.live_grep({ 'rg', '--no-config', '--files', '--hidden', '--no-ignore' })
end, {})
vim.keymap.set('n', '<C-p>', function()
    telbuiltin.find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
end, {})
vim.keymap.set('n', '<C-S-P>', function()
    telbuiltin.live_grep({ 'rg', '--no-config', '--files', '--hidden', '--no-ignore' })
end, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>pp', telbuiltin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>k', "<cmd>Telescope keymaps<cr>")
vim.keymap.set('n', '<leader>h', "<cmd>Telescope help_tags<cr>")
vim.keymap.set('n', '<leader>pb', "<cmd>Telescope builtin<cr>")


-- Trouble
vim.keymap.set('n', '<leader>li', "<cmd>Trouble lsp_incoming_calls<cr>")
vim.keymap.set('n', '<leader>t', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set('n', '<leader>T', "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set('n', '<leader>ls', function()
    vim.cmd("Trouble symbols toggle")
    require("trouble").fold_more() ---@diagnostic disable-line because Trouble docs say this is ok
end)
-- the keymaps for within trouble views are in ./plugins/trouble.lua

-- formatting
vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')


-- undotree
vim.keymap.set({ 'n', 'i' }, '<F1>', vim.cmd.UndotreeToggle)
vim.keymap.set({ 'n' }, '<leader>u', vim.cmd.UndotreeToggle)

-- debugging
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set({ 'n', 'i' }, '<F5>', dap.step_into)
vim.keymap.set({ 'n', 'i' }, '<F6>', dap.step_over)
vim.keymap.set({ 'n', 'i' }, '<F7>', dap.step_out)
vim.keymap.set({ 'n', 'i' }, '<F8>', dap.continue)
vim.keymap.set({ 'n', 'i' }, '<F32>', dap.run_last) -- Ctrl F8
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set({'n', 'v'}, '<leader>e', dapui.eval)
-- vim.keymap.set('n', '<Leader>dr', function()
--     dap.repl.toggle({}, 'vert rightbelow split')
--     vim.cmd("normal! <C-w>l")
-- end)
vim.keymap.set('n', '<leader>dd', dap.down)
vim.keymap.set('n', '<leader>du', dap.up)
vim.keymap.set('n', '<leader>dj', dap.goto_)
vim.keymap.set('n', '<leader>dm', function() require("dap-python").test_method { config = { justMyCode = false } } end)
vim.keymap.set('n', '<F20>', dap.terminate) -- F20 is obviously the same as Shift+F8 (in windows terminal)
vim.keymap.set('n', '<leader>dr', function() dapui.toggle { reset = true } end)
vim.keymap.set('n', '<leader>dvt', "<cmd>DapVirtualTextToggle<cr>")


-- Harpoon -- Harboon is out for now because it has a bug I can't reproduce so I don't use it
-- local harpoon = require("harpoon")
-- vim.keymap.set("n", "<C-e>", function() misc.harpoon_toggle_telescope(harpoon:list()) end,
--     { desc = "Open harpoon window" })
-- vim.keymap.set('n', '<leader>a', function()
--     print("Added buffer to harpoon"); harpoon:list():add()
-- end)
-- vim.keymap.set('n', '<leader>n', function() harpoon:list():next() end)
-- vim.keymap.set('n', '<leader>p', function() harpoon:list():prev() end)
-- vim.keymap.set('n', '<leader>r', function()
--     print("removed buffer from harpoon"); harpoon:list():remove()
-- end)

-- Zettelkasten (requires zk to be installed)
--NOTE docs are at https://github.com/zk-org/zk-nvim
-- local zk = require("zk")
vim.keymap.set('n', '<leader>np', '<cmd>ZkNotes<cr>')
vim.keymap.set('n', '<leader>nc', '<cmd>ZkNew<cr>')
vim.keymap.set('n', '<leader>ni', '<cmd>ZkIndex<cr>')
vim.keymap.set('n', '<leader>nm', '<cmd>e /home/miguel/notes/fmbj.md<cr>') -- Yes, I hardcoded that path. Go cry about it
vim.keymap.set('n', '<leader>nt', '<cmd>ZkTags<cr>')


-- Git
-- TODO signcolumn background for git indicators
local gitsigns = require("gitsigns")
vim.keymap.set('n', ']c', function() gitsigns.nav_hunk('next') end)
vim.keymap.set('n', '[c', function() gitsigns.nav_hunk('prev') end)
vim.keymap.set('n', '<leader>gd', function() gitsigns.diffthis(nil, {vertical=true, split="rightbelow"}) end, {desc = "git diff"})
vim.keymap.set('n', '<leader>ga', function() gitsigns.stage_hunk() end, {desc = "git add for the current change"})
vim.keymap.set('n', '<leader>gt', function() gitsigns.setqflist('all') end, {desc = "Open all unstaged changes in Trouble"})
vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk() end, {desc = "Preview current change"})

-- Oil (file browser)
vim.keymap.set('n', '-', "<cmd>Oil<cr>")


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
--example link: http://www.linusakesson.net/programming/tty/
vim.keymap.set({ 'n', 'v' }, 'gx', misc.gx)
vim.keymap.set('n', '<leader>B', '<cmd>BlameToggle<cr>')

vim.keymap.set('t', '<Esc><Esc>', "<C-\\><C-n>") --TODO this still broken




-- this is getting out of hand. We need some categories for keymaps so I can remember them
-- sd* for debugging
-- sn* for notes
--TODO ss for 'show' -> Undotree, blame, diagnostic virtualtext
--TODO sg for git stuff

local todocomments = require("todo-comments")
vim.keymap.set("n", "]t", function() todocomments.jump_next() end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function() todocomments.jump_prev() end, { desc = "Previous todo comment" })
