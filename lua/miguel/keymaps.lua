-- this is getting out of hand. We need some categories for keymaps so I can remember them
-- sd* for debugging
-- sn* for notes
-- sg for git stuff
-- sl for LSP functions
-- g* also does LSP stuff but shhh
-- sp for telescope
-- sa for AI stuff


local misc = require("miguel.misc")

-- make sure leader is also set directly in the main init.lua
vim.g.mapleader = 's'
vim.g.maplocalleader = 's'
vim.keymap.set('n', 'S', 's', {})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-c>', '<Esc>') -- without this, diagnostics sometimes stay hidden after exiting insert mode

-- LSP Stuff
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)

vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions toggle<cr>')
vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end)
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references toggle<cr>zz')
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
vim.keymap.set('n', '<leader>li', misc.apply_inlay_hint, { desc = "Apply inlay hint after cursor" })

-- remove some default nvim mappings so `gr` works like I'm used to
vim.keymap.del({'n', 'x'}, 'gra')
vim.keymap.del('n', 'grn' )
vim.keymap.del('n', 'gri' )
vim.keymap.del('n', 'grr' )


local conform_callback = function(err, did_edit) ---@diagnostic disable-line unused-local
    if err then
        vim.print("Conform callback here. We got an error: ", err)
    end
end

-- vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({async = true}) end)
vim.keymap.set({ 'n', 'v' }, '<F3>', function() require("conform").format() end)
vim.keymap.set({ 'n', 'v' }, '<F3>', function() require("conform").format() end)
pcall(vim.keymap.del, 'o', 'gq')
vim.keymap.set({ 'v', 'o' }, 'gq',
    function() require("conform").format({ bufnr = 0, timeout_ms = 5000 }, conform_callback) end,
    { desc = "Format using conform.nvim", callback = function() vim.print("gq called") end }) --TODO the operator pending mapping doesn't trigger the callback and does weird formatting. If provide a callback to vim.keymap.set, it isn't triggered. So there's some other mapping screwing with me. vim.keymap.del above seems to not help. Is this a but in nvim?
-- require("conform").format_lines -- might be the thing I need instead


-- Telescope
local telbuiltin = require('telescope.builtin')
local find_files = function()
    telbuiltin.find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
end
local live_grep = function()
    telbuiltin.live_grep({ 'rg', '--no-config', '--files', '--hidden', '--no-ignore' })
end
vim.keymap.set('n', '<C-p>', find_files, {})
vim.keymap.set('n', '<F37>', live_grep, { desc = "Live Grep" }) -- for windows terminal <C-S-P>
vim.keymap.set('n', '<C-S-P>', live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>pg', live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>ps', telbuiltin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>pp', find_files)
vim.keymap.set('n', '<leader>k', "<cmd>Telescope keymaps<cr>")
vim.keymap.set('n', '<leader>h', "<cmd>Telescope help_tags<cr>")
vim.keymap.set('n', '<leader>pB', "<cmd>Telescope builtin<cr>")
vim.keymap.set('n', '<leader>pb', '<cmd>Telescope buffers<cr>')


-- Refactoring
vim.keymap.set({'n', 'v'}, '<leader>rr', function ()
    require("telescope").extensions.refactoring.refactors()
end)
vim.keymap.set({'n','v'}, '<leader>re', ':Refactor extract ')
vim.keymap.set({'n','v'}, '<leader>rf', ':Refactor extract_to_file ')
vim.keymap.set({'n','v'}, '<leader>rif', ':Refactor inline_func')
vim.keymap.set({'n','v'}, '<leader>riv', ':Refactor inline_var')
vim.keymap.set({'n','v'}, '<leader>rb', ':Refactor extract_block')


-- Trouble
vim.keymap.set('n', '<leader>t', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set('n', '<leader>T', "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set('n', '<leader>ls', function()
    vim.cmd("Trouble symbols toggle")
    require("trouble").fold_more() ---@diagnostic disable-line because Trouble docs say this is ok
end)
-- the keymaps for within trouble views are in ./plugins/trouble.lua


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
vim.keymap.set({ 'n', 'i' }, '<F32>', dap.run_last) -- Ctrl F8 in tmux
vim.keymap.set({ 'n', 'i' }, '<C-F8>', dap.run_last)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set({'n', 'v'}, '<leader>e', dapui.eval)
-- vim.keymap.set('n', '<Leader>dr', function()
--     dap.repl.toggle({}, 'vert rightbelow split')
--     vim.cmd("normal! <C-w>l")
-- end)
vim.keymap.set('n', '<leader>dd', dap.down, {desc = 'Debugger: down in stack'})
vim.keymap.set('n', '<leader>du', dap.up, {desc = 'Debugger: up in stack'})
vim.keymap.set('n', '<leader>dj', dap.goto_, {desc = 'Debugger: jump to cursor'})
vim.keymap.set('n', '<leader>dm', function() require("dap-python").test_method { config = { justMyCode = false } } end, {desc = 'Debug test under cursor'})
vim.keymap.set('n', '<F20>', dap.terminate, {desc = 'Debugger: Terminate'}) -- F20 is obviously the same as Shift+F8 (in windows terminal)
vim.keymap.set('n', '<S-F8>', dap.terminate, {desc = 'Debugger: Terminate'}) -- F20 is obviously the same as Shift+F8 (in windows terminal)
vim.keymap.set('n', '<leader>dr', function() dapui.toggle { reset = true } end, {desc='Debugger: show/hide'})
vim.keymap.set('n', '<leader>dvt', "<cmd>DapVirtualTextToggle<cr>", {desc='Debugger: Toggle virtual text'})


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
vim.keymap.set('n', '<leader>pn', '<cmd>ZkNotes<cr>')
vim.keymap.set('n', '<leader>nc', '<cmd>ZkNew<cr>')
vim.keymap.set('n', '<leader>ni', '<cmd>ZkIndex<cr>')
vim.keymap.set('n', '<leader>nm', '<cmd>e /home/miguel/notes/fmbj.md<cr>') -- Yes, I hardcoded that path. Go cry about it
vim.keymap.set('n', '<leader>nt', '<cmd>ZkTags<cr>')
vim.api.nvim_set_keymap("n", "<leader>ng",
    "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
    { noremap = true, silent = false })



-- Git
-- TODO signcolumn background for git indicators
local gitsigns = require("gitsigns")
vim.keymap.set('n', ']c', function() gitsigns.nav_hunk('next') end)
vim.keymap.set('n', '[c', function() gitsigns.nav_hunk('prev') end)
vim.keymap.set('n', '<leader>gd', function() gitsigns.diffthis(nil, {vertical=true, split="rightbelow"}) end, {desc = "git diff"})
vim.keymap.set('n', '<leader>ga', function() gitsigns.stage_hunk() end, {desc = "git add for the current change"})
vim.keymap.set('n', '<leader>gt', function() gitsigns.setqflist('all') end, {desc = "Open all unstaged changes in Trouble"})
vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk() end, {desc = "Preview current change"})
vim.keymap.set('n', '<leader>B', '<cmd>BlameToggle<cr>', {desc = "Blame (from old plugin)"})
vim.keymap.set('n', '<leader>gb', function() gitsigns.blame() end, {desc = "blame"})
--TODO map sgD to diff but with prompt for branch/commit instead of always doing HEAD

-- Oil (file browser)
vim.keymap.set('n', '-', "<cmd>Oil<cr>")


-- todocomments
local todocomments = require("todo-comments")
vim.keymap.set("n", "]t", function() todocomments.jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() todocomments.jump_prev() end, { desc = "Previous todo comment" })


-- Molten
vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Enter Molten Output window" })
vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate defined cell" })
vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>", { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "]m", ":MoltenNext<cr>", { silent = true})
vim.keymap.set("n", "[m", ":MoltenPrev<cr>", { silent = true})


-- vim-dadbod-ui
vim.keymap.set("n", "<leader>od", "<cmd>tab DBUI<cr>")

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
--example link: http://www.linusakesson.net/programming/tty
vim.keymap.set({ 'n', 'v' }, 'gx', misc.gx)
vim.keymap.set('n', '<leader>fml', function()
    vim.cmd('CellularAutomaton make_it_rain')
    vim.cmd[[set nowrap]]
end)
vim.keymap.set('n', '<leader>fmn', '<cmd>CellularAutomaton game_of_life<cr>')

-- Terminal stuff
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.keymap.set('n', 'gF', misc.gf, { buffer = 0, noremap = true })
        vim.keymap.set('n', 'gf', misc.gf, { buffer = 0, noremap = true })
    end
})
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {desc="Exit insert mode in terminal"})
vim.api.nvim_create_user_command('VT', misc.vt, {})
vim.api.nvim_create_user_command('Vt', misc.vt, {})

-- Windows stopped supporting MSKLC so I have to do this BS to type Umlauts. Fuck you, Microsoft
vim.keymap.set('i', '<M-o>', "ö")
vim.keymap.set('i', '<M-a>', "ä")
vim.keymap.set('i', '<M-u>', "ü")
vim.keymap.set('i', '<M-s>', "ß")
vim.keymap.set('i', '<M-O>', "Ö")
vim.keymap.set('i', '<M-A>', "Ä")
vim.keymap.set('i', '<M-U>', "Ü")
vim.keymap.set('i', '<M-S>', "ẞ")


-- AI Stuff
vim.keymap.set('n', '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>')
vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat<cr>')
vim.keymap.set('n', '<leader>ap', '<cmd>CodeCompanionActions<cr>')
vim.keymap.set('n', '<leader>pa', '<cmd>CodeCompanionActions<cr>')
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanion /explain<cr>')
vim.keymap.set('i', '<C-E>', '<Plug>(copilot-suggest)')

-- blink.cmp does something with <C-K> despite me telling it not to, so...
pcall(vim.keymap.del, 'i', '<C-K>', {buffer=true}) -- pcall because blink keeps changing


-- Colortheme
current_colorscheme = "shades_of_purple"
vim.keymap.set('n', '<leader>cs', Shadesofpurple)
vim.keymap.set('n', '<leader>cb', ':colorscheme bamboo<cr>')
