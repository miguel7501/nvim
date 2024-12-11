return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
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
                        position = "right",
                        size = 0.25,
                    },
                    -- preview = {
                    --     type = "split",
                    --     -- relative = "win",
                    --     position= "below",
                    -- },
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
                            },
                        },
                    },
                },
            },
            warn_no_results = false,
        }
    end
}
