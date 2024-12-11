return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.basedpyright.setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "basic",
                        -- logLevel = "Trace",
                    }
                }
            } }
        lspconfig.lua_ls.setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                        reportMissingTypeStubs = false
                    }
                }
            }
        }
    end
}
