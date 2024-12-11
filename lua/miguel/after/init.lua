

-- debugger setup
        local dap = require('dap')
        vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='→', texthl='', linehl='WildMenu', numhl=''})

        local dapui = require("dapui")
        dap.listeners.before['event_exited']['dapui'] = dapui.close
        dap.listeners.before['event_initialized']['dapui'] = dapui.open


-- Stuff
vim.cmd("SpeedDatingFormat %d.%m.%Y")
dap.set_log_level("TRACE")

-- Open Oil with preview enabled
local oil = require("oil")
vim.api.nvim_create_autocmd("User", {
    pattern = "OilEnter",
    callback = function(args)
        local bufnr = vim.api.nvim_get_current_buf()
        if args.data.buf == bufnr then
            local callback = oil.open_preview
            vim.api.nvim_buf_call(bufnr, callback)
            return true
        end
    end,
})
