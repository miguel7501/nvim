-- debugger setup
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
-- vim.api.nvim_create_autocmd({"BufDelete", "BufWipeout"}, { --TODO close dapui when quitting vim so I don't have to do it manually
--     pattern = '*',
--     callback = function ()
--         local bufinfo =  vim.fn.getbufinfo({bufloaded=1})
--         local n_buffers = 0
--         for buf in bufinfo do
--             print("Buf:")
--             print(vim.inspect(buf))
--             if buf["hidden"] == 0 then
--                 n_buffers = n_buffers + 1
--             end
--         end
--         if n_buffers == 0 then
--             dapui.close()
--         end
--
--     end
-- })


-- Stuff
vim.cmd("SpeedDatingFormat %d.%m.%Y")
dap.set_log_level("TRACE")
