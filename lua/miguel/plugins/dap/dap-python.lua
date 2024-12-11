return {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", },
    config = function()
        local dap = require('dap')
        local dap_python = require("dap-python")
        dap_python.setup("python")
        dap_python.test_runner="pytest"
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = vim.fn.getcwd
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
