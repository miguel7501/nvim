return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "CustomDapBg", numhl = "" })
        dap.listeners.after["event_exited"]["dapui"] = function(session, body)
            local exitCode = body["exitCode"]
            if exitCode == 0 or exitCode == 247 then -- 247 means manual termination
                dapui.close()
            end
        end
        dap.listeners.before["event_initialized"]["dapui"] = dapui.open

        dap_python.setup("python")
        dap_python.test_runner = "pytest"
        dap.configurations.python = require("dap_configs").dap_launch_configs
        require("dapui").setup(require("dap_configs").dap_virtual_text)

        dap_virtual_text.setup({ ---@diagnostic disable-line:missing-fields
            virt_text_pos = "eol",
            display_callback = function(variable, buf, stackframe, node, options)
                if options.virt_text_pos == "inline" then
                    return " = " .. variable.type
                else
                    local val = string.gsub(variable.value, "%s+", " ")
                    return "■ " .. val
                end
            end,
        })

        -- keymaps
        local dap = require('dap')
        local dapui = require('dapui')
        vim.keymap.set({ 'n', 'i' }, '<F5>', dap.step_into, { desc = 'Debugger: step into' })
        vim.keymap.set({ 'n', 'i' }, '<F6>', dap.step_over, { desc = 'Debugger: step over' })
        vim.keymap.set({ 'n', 'i' }, '<F7>', dap.step_out, { desc = 'Debugger: step out' })
        vim.keymap.set({ 'n', 'i' }, '<F8>', dap.continue, { desc = 'Debugger: continue' })
        vim.keymap.set({ 'n', 'i' }, '<C-F8>', dap.run_last, { desc = 'Debugger: run last configuration' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debugger: toggle breakpoint' })
        vim.keymap.set({ 'n', 'v' }, '<leader>e', dapui.eval, { desc = 'Debugger: eval' })
        vim.keymap.set('n', '<leader>dd', dap.down, { desc = 'Debugger: down in stack' })
        vim.keymap.set('n', '<leader>du', dap.up, { desc = 'Debugger: up in stack' })
        vim.keymap.set('n', '<leader>dj', dap.goto_, { desc = 'Debugger: jump to cursor' })
        vim.keymap.set('n', '<leader>dm',
            function() require("dap-python").test_method { config = { justMyCode = false } } end,
            { desc = 'Debug test under cursor' })
        vim.keymap.set('n', '<leader>dr', function() dapui.toggle { reset = true } end, { desc = 'Debugger: show/hide' })
        vim.keymap.set('n', '<leader>dvt', "<cmd>DapVirtualTextToggle<cr>", { desc = 'Debugger: Toggle virtual text' })
    end,
}
