return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = 'v0.*',

        opts = {
            keymap = {
                preset = 'default',
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            signature = { enabled = true },
            sources = {
                providers = {
                    cmdline = {
                        enabled = function ()
                            return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():find('!')
                        end
                    }
                }
            }
        },
    },
}
