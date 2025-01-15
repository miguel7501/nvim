return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
            max_items = 1000,
            modes = {
                lsp_base = {
                    focus = true,
                    auto_close = true,
                },
                diagnostics = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.5,
                        scratch = false,
                    },
                    focus = true,
                    auto_close = true,
                    win = {
                        size = 0.3,
                    }
                },
                symbols = {
                    mode = "lsp_document_symbols",
                    focus = true,
                    auto_close = false,
                    win = {
                        -- position = "bottom",
                        position = "right", --TODO split to the right if there's just one open buffer (ignoring dapui) and below if there are more
                        size = 0.25,
                    },
                    -- preview = {
                    --     type = "split",
                    --     -- relative = "win",
                    --     position= "below",
                    -- },
                    preview = { scratch = false },
                    filter = {
                        any = {
                            kind = {
                                "Class",
                                "Constructor",
                                "Enum",
                                "Field",
                                "Function",
                                "Interface",
                                "Method",
                                "Module",
                                "Namespace",
                                "Package",
                                "Property",
                                "Struct",
                                "Trait",
                                "Variable",
                            },
                        },
                    },
                },
            },
            warn_no_results = false,
        }
    end
}
