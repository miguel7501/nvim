local set = vim.opt_local

set.colorcolumn = "100"

local misc = require("miguel.misc")
local function black()
    misc.preserve_cursor(vim.cmd, "Black")
end

vim.keymap.set({ 'n', 'x' }, '<F3>', black, {buffer = 0}) -- yes, this is botchery. No, I don't care
