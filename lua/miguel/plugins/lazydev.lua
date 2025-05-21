return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        config = function()
            require('lazydev').setup {
                library = {
                    "nvim-dap-ui"
                },
                integrations = {
                    lspconfig = true
                },
                -- debug = true,
            }
        end,
    },
}
