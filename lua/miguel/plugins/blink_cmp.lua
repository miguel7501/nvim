return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-avante",
        },
        version = "v0.*",
        opts = {
            completion = {
                menu = {
                    auto_show = true,
                },
            },
            keymap = {
                preset = "default",
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["C-K"] = {},
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono"
            },
            signature = { enabled = true },
            sources = {
                -- default = {
                --     "avante", "lsp", "luasnip", "path", "buffer",
                -- },
                per_filetype = {
                    sql = { "dadbod", "buffer"},
                    mysql = { "dadbod", "buffer"},
                },
                providers = {
                    cmdline = {
                        enabled = function()
                            local cmdline = vim.fn.getcmdline()
                            return vim.fn.getcmdtype() ~= ":" or ( not cmdline:find("!") and not cmdline:find("%%") and not cmdline:find("term "))
                        end
                    },
                    dadbod = { name = "dadbod", module = "vim_dadbod_completion.blink" }
                }
            }
        },
    },
}
