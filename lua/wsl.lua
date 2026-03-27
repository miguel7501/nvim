-- WSL specific stuff. init.lua only loads this in WSL

local dap = require("dap")

vim.keymap.set({ 'n', 'i' }, '<F32>', dap.run_last)      -- Ctrl F8 in wsl tmux
vim.keymap.set({ 'n', 'i' }, '<F20>', dap.terminate)     -- Ctrl F8 in wsl tmux
vim.keymap.set({ 'n', 'v' }, 'gx', require("functions").sad_gx)
-- Windows stopped supporting MSKLC so I have to do this BS to type Umlauts. Fuck you, Microsoft
vim.keymap.set('i', '<M-o>', "ö")
vim.keymap.set('i', '<M-a>', "ä")
vim.keymap.set('i', '<M-u>', "ü")
vim.keymap.set('i', '<M-s>', "ß")
vim.keymap.set('i', '<M-O>', "Ö")
vim.keymap.set('i', '<M-A>', "Ä")
vim.keymap.set('i', '<M-U>', "Ü")
vim.keymap.set('i', '<M-S>', "ẞ")

