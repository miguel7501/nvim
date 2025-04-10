-- debugger setup needs to happen here because both dap and dapui need to have their setup() called before
local dap = require('dap')
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = '', linehl = 'WildMenu', numhl = '' })

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


-- 0.11 made floats weird, this attempts to fix them. The docs say specifically not to do this, but this is neovim and they can't stop me.
vim.api.nvim_create_autocmd({'OptionSet'},
{
    pattern={"conceallevel", "concealcursor"},
    command = [[
        set conceallevel=1
        set concealcursor=
    ]]
    -- callback = function (args)
    --     vim.print("Stupid fucking Callback here. Args:",args)
    --     vim.print("v.option_type: ", vim.v.option_type)
    --     vim.print("v.option_command: ", vim.v.option_command)
    --     vim.print("v.option_new: ", vim.v.option_new)
    --     vim.print("v.option_oldlocal: ", vim.v.option_oldlocal)
    --     vim.print("v.option_oldglobal: ", vim.v.option_oldlocal)
    -- end
})


-- Stuff
vim.cmd("SpeedDatingFormat %d.%m.%Y")
