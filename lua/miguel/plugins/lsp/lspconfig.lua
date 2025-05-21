
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- local lspconfig = require("lspconfig")

        -- lspconfig.lua_ls.setup {
        --     capabilities = require('blink.cmp').get_lsp_capabilities(),
        --     settings = {
        --         Lua = {
        --             diagnostics = {
        --                 reportMissingTypeStubs = false
        --             }
        --         }
        --     }
        -- }
        -- lspconfig.sqls.setup{
        --     capabilities = require('blink.cmp').get_lsp_capabilities(),
        -- }

    end
}
