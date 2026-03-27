local M = {}

M.dap_launch_configs = {
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
        justMyCode = false,
        console = "integratedTerminal"
    },
}

M.dap_virtual_text = {
    controls = {
        element = "repl",
        enabled = false,
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = { {
        elements = { {
            id = "repl",
            size = 0.5
        }, {
            id = "console",
            size = 0.5
        } },
        position = "bottom",
        size = 10
    }, {
        elements = { {
            --   id = "scopes",
            --   size = 0.25
            -- }, {
            id = "breakpoints",
            size = 0.25
        }, {
            id = "stacks",
            size = 0.25
        }, {
            id = "watches",
            size = 0.25
        } },
        position = "left",
        size = 40
    } },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
}

return M
