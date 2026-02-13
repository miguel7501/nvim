return {
    "zbirenbaum/copilot.lua",
    -- requires = { -- not working yet
    --     "copilot-lsp/copilot-lsp",
    --     init = function()
    --         vim.g.copilot_nes_debounce = 300
    --     end,
    -- },
    config = function()
        require('copilot').setup({
            server_opts_overrides = {
                settings = {
                    telemetry = {
                        telemetryLevel = "off",
                    },
                },
            },
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    -- open = "<M-CR>"
                    open = "<M-CR>" -- TODO figure out which modes this mapping is for
                    -- see ../keymaps.lua for more mappings
                },
                layout = {
                    position = "bottom", -- | top | left | right | bottom |
                    ratio = 0.4
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 15,
                trigger_on_accept = true,
                keymap = {
                    accept = false,
                    accept_word = "<Tab>",
                    accept_line = "<S-Tab>",
                    next = "<C-E>",
                    -- prev = "<C-S-E>",
                    dismiss = "<C-]>",
                    toggle_auto_trigger = false,
                },
            },
            nes = {
                enabled = false, -- requires copilot-lsp as a dependency
                auto_trigger = false,
                keymap = {
                    accept_and_goto = false,
                    accept = "<leader>i",
                    dismiss = false,
                },
            },
            auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
            logger = {
                file = vim.fn.stdpath("log") .. "/copilot-lua.log",
                file_log_level = vim.log.levels.OFF,
                print_log_level = vim.log.levels.WARN,
                trace_lsp = "off", -- "off" | "debug" | "verbose"
                trace_lsp_progress = false,
                log_lsp_messages = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 22
            workspace_folders = {},
            copilot_model = "",
            disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
            root_dir = function()
                return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
            end,
            should_attach = function(bufnr, path) -- TODO prevent this from attaching to nvim-dap-ui stuff
                if not vim.bo.buflisted then
                    return false
                end

                if vim.bo.buftype ~= "" then
                    return false
                end
                if path:match(".*notes.*") then
                    print("Notes folder detected, disabling Copilot")
                    return false
                end

                return true
            end,
            server = {
                type = "nodejs", -- "nodejs" | "binary"
                custom_server_filepath = nil,
            },
        })
        vim.keymap.set("i", "<C-P>", "<cmd>Copilot panel<cr>", { desc = "Open Copilot panel" })
    end
}
