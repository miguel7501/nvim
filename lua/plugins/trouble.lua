return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
            max_items = 1000,
            keys = {
                s = "fold_more",
                S = "fold_reduce",
                ["<cr>"] = "jump_close",
                o = "jump",
            },
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
        vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions toggle<cr>')
        vim.keymap.set('n', 'grt', '<cmd>Trouble lsp_references toggle<cr>zz')
        vim.keymap.set('n', '<leader>t', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
        vim.keymap.set('n', '<leader>T', "<cmd>Trouble diagnostics toggle<cr>")
        vim.keymap.set('n', '<leader>ls', function()
            vim.cmd("Trouble symbols toggle")
            -- this folds by one layer initially
            require("trouble").fold_more()
            require("trouble").fold_more()
        end)
    end
}
