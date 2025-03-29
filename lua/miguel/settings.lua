vim.g.mapleader = 's'
vim.g.maplocalleader = 's'
vim.keymap.set({'n', 'v'}, 's', '<Nop>', {})
vim.keymap.set({'n', 'v'}, 'S', 's', {})

vim.opt.timeout = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 200
vim.opt.number = true
vim.opt.relativenumber = true

-- tmux
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yoinking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yoink', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- :python
vim.g.python3_host_prog = '/home/miguel/scripts/python/.venv/bin/python3'

-- automatically remove trailing spaces
local group1 = vim.api.nvim_create_augroup("group1", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = group1,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

