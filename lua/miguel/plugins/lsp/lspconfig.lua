return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --     "hrsh7th/cmp-nvim-lsp",
    -- },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.basedpyright.setup {
            -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            settings = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "basic",
                        -- logLevel = "Trace",
                        diagnosticMode = "workspace",
                    }
                }
            },
            -- on_attach = function (client, bufnr) --TODO check if that works without the plugin
            --     require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            -- end
        }
        lspconfig.lua_ls.setup {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            settings = {
                Lua = {
                    diagnostics = {
                        reportMissingTypeStubs = false
                    }
                }
            }
        }
    end
}
