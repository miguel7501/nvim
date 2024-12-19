return {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", },
    config = function()
        local dap = require('dap')
        local dap_python = require("dap-python")
        dap_python.setup("python")
        dap_python.test_runner = "pytest"
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = vim.fn.getcwd
            },
            {
                name = "Python Debugger: Current file but global config",
                type = "debugpy",
                request = "launch",
                program = "${file}",
                -- cwd = "/home/miguel/py/quality/labconnect",
                cwd = ".",
                justMyCode = false,
                debugOptions = { "RedirectOutput" },
                console = "integratedTerminal",
            },
            {
                type = 'python',
                request = 'launch',
                name = "Pytest",
                program = "pytest",
                pythonPath = vim.fn.getcwd
            },
        }
    end
}
