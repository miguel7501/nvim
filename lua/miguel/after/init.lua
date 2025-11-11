-- debugger setup needs to happen here because both dap and dapui need to have their setup() called before
local dap = require('dap')
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = '', linehl = 'CustomDapBg', numhl = '' })

local dapui = require("dapui")
dap.listeners.after['event_exited']['dapui'] = function(session, body)
    -- print(vim.inspect(session))
    -- print("Body:")
    -- print(vim.inspect(body))
    local exitCode = body["exitCode"]
    if exitCode == 0 or exitCode == 247 then -- 247 happens on manual termination
        dapui.close()
    end
end
dap.listeners.before['event_initialized']['dapui'] = dapui.open
dap.set_log_level("TRACE")


-- TODO this stupid
-- -- 0.11 made floats weird, this attempts to fix them. The docs say specifically not to do this, but this is neovim and they can't stop me.
-- vim.api.nvim_create_autocmd({'OptionSet'},
-- {
--     pattern={"conceallevel", "concealcursor"},
--     command = [[
--         set conceallevel=1
--         set concealcursor=
--     ]]
-- })


-- Stuff
vim.cmd("SpeedDatingFormat %d.%m.%Y")


-- -- move statusline one up only if I use the command line
-- vim.api.nvim_create_autocmd("CmdLineEnter",
--     { callback = function() vim.opt.cmdheight = 1 end })
-- vim.api.nvim_create_autocmd("CmdLineLeave",
--     { callback = function() 
--         vim.opt.cmdheight = 0
--     end })
-- TODO this hides macro recording
-- TODO this makes it so a :w causes "hit enter" prompt
-- so we need more conditions to handle it properly
