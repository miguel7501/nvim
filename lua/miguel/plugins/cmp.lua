-- return {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--         "hrsh7th/cmp-buffer", -- source for text in buffer
--         "hrsh7th/cmp-path",   -- source for file system paths
--     },
--     config = function()
--         local cmp = require("cmp")
--         cmp.setup({
--             mapping = cmp.mapping.preset.insert({
--                 ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-u>"] = cmp.mapping.scroll_docs(4),
--                 ["<C-Space>"] = cmp.mapping.complete(),
--                 ["<C-e>"] = cmp.mapping.close(),
--                 ["<C-y>"] = cmp.mapping.confirm({
--                     behavior = cmp.ConfirmBehavior.Replace,
--                     select = true,
--                 }),
--             }),
--                 sources = cmp.config.sources({
--                     { name = "nvim_lsp" },
--                     { name = "path" },
--                 })
--             })
--     end
-- }
--
return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = 'v0.*',

        opts = {
            enabled = function ()
                if vim.fn.mode() == 'c' and vim.fn.getcmdline():find("!") -- no autocomplete for external commands because WSL
                    or vim.bo.filetype == "TelescopePrompt" -- and no autocomplete for telescope because why would there be
                then
                    return false
                end
                return true
            end,
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
            -- sources = {
            --     default = {'lsp', 'snippets', 'buffer'} --path is out because wsl
            -- }
        },
    },
}
