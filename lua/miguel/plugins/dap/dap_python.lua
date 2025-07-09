return {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", },
    config = function()
        local dap = require('dap')
        local dap_python = require("dap-python")
        dap_python.setup("python")
        dap_python.test_runner = "pytest"
        dap.configurations.python = {
            -- {
            --     type = 'python',
            --     request = 'launch',
            --     name = "Launch file",
            --     program = "${file}",
            --     pythonPath = vim.fn.getcwd
            -- },
            {
                name = "Current python file",
                type = "debugpy",
                request = "launch",
                program = "${file}",
                cwd = ".",
                justMyCode = false,
                debugOptions = { "RedirectOutput" },
                console = "integratedTerminal",
            },
            {
                name = "Pytest (all)",
                type = "debugpy",
                request = "launch",
                module = "pytest",
                console = "integratedTerminal"
            },
        }
    end
}
