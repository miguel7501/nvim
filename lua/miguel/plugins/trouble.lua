return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
            max_items = 1000,
            keys = {
                s = "fold_more",
                S = "fold_reduce",
                ["<cr>"] = "jump_close",
            },
            modes = {
                -- gitsigns does this: require('trouble').open('loclist')
                loclist = { -- this is for gitsigns --TODO but it do not be working
                    focus = true,
                    preview = { --TODO we want main buffer preview
                        type = "main",
                        scratch = false,
                    }
                },
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
                    auto_close = true,
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
