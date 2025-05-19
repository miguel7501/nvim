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
        lspconfig.sqls.setup{
            capabilities = require('blink.cmp').get_lsp_capabilities(),
        }

      -- -- copied from `:h lsp`
      -- vim.lsp.config['luals'] = {
      --   -- Command and arguments to start the server.
      --   cmd = { 'lua-language-server' },
      --
      --   -- Filetypes to automatically attach to.
      --   filetypes = { 'lua' },
      --
      --   -- Sets the "root directory" to the parent directory of the file in the
      --   -- current buffer that contains either a ".luarc.json" or a
      --   -- ".luarc.jsonc" file. Files that share a root directory will reuse
      --   -- the connection to the same LSP server.
      --   root_markers = { '.luarc.json', '.luarc.jsonc' },
      --
      --   -- Specific settings to send to the server. The schema for this is
      --   -- defined by the server. For example the schema for lua-language-server
      --   -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
      --   settings = {
      --     Lua = {
      --       runtime = {
      --         version = 'LuaJIT',
      --       }
      --     }
      --   }
      -- }
      -- vim.lsp.enable('luals')

    end
}
