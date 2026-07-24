vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    root_markers = { '.git' },
})


vim.lsp.config['basedpyright'] = {
    cmd = { 'basedpyright-langserver', '--stdio', '--threads', '16' },
    filetypes = { 'python' },
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
                -- logLevel = "Trace",
                diagnosticMode = "workspace",
            }
        }
    },
}
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff', false) -- ruff LSP is annoying, I just use it as formatter


local lua_libs = { "?/init.lua", "?.lua",}
local disabled_diagnostics = {}
local cwd = vim.fn.getcwd()
if cwd == vim.fn.expand("~/.config/nvim") then -- we are configuring nvim
    table.insert(lua_libs, vim.env.VIMRUNTIME) -- nvim builtins
    table.insert(lua_libs, vim.fn.stdpath("data") .. "/lazy") -- all plugin code
    table.insert(disabled_diagnostics, "PARSER_LUADOC_MISS_SEE_NAME")
elseif string.match(cwd, "love2d") then
    table.insert(lua_libs, vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/love2d.nvim/libraries/luasocket/library"))
    table.insert(lua_libs, vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/love2d.nvim/libraries/love2d/library"))
    table.insert(disabled_diagnostics, "duplicate-set-field")

end
vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            hover = {
                previewFields = 0 , -- no limit, default is 20 or so.
                -- enumsLimit = 0, -- Claude mentioned that for union types, maybe I'll need it
            },
            runtime = {
                version = 'LuaJIT',
                path = lua_libs,
            },
            diagnostics = {
                disable = disabled_diagnostics,
            },
            workspace = {
                library = lua_libs,
            }
        }
    },
}
vim.lsp.enable('lua_ls')

if not Sad then
    vim.lsp.config["glsl_analyzer"] = {
        cmd = { "glsl_analyzer" },
        filetypes = {"glsl"}
    }
    vim.lsp.enable("glsl_analyzer")
end

vim.lsp.enable('bashls')


vim.lsp.config['svelte'] = {
    cmd = { 'svelteserver', '--stdio' },
    filetypes = { 'svelte' },
    settings = {
        typescript = {
            inlayHints = {
                enumMemberValues = {
                    enabled = true
                },
                functionLikeReturnTypes = {
                    enabled = true
                },
                parameterNames = {
                    enabled = "literals",
                    suppressWhenArgumentMatchesName = true
                },
                parameterTypes = {
                    enabled = true
                },
                propertyDeclarationTypes = {
                    enabled = true
                },
                variableTypes = {
                    enabled = true
                }
            }
        }
    }
}
vim.lsp.enable { 'svelte', "ts_ls" } -- ts_ls = typescript



vim.api.nvim_create_autocmd("LspAttach",
    {
        -- pattern={"basedpyright"},
        callback = function(evt)
            local lsp_client = vim.lsp.get_client_by_id(evt.data.client_id)
            if lsp_client == nil then
                return nil
            end
            if not lsp_client:supports_method("textDocument/foldingRange") then
                return nil
            end
            vim.opt_local.foldmethod = 'expr'
            vim.opt_local.foldexpr = 'v:lua.vim.lsp.foldexpr()'
            vim.opt_local.foldlevelstart = 99
            vim.opt_local.foldlevel = 99
        end
    })

-- TODO I am not sure whether this actually disables telemetry but how do I find out?

-- vim.lsp.config['docker-language-server'] = {
--     cmd = { 'docker-language-server', 'start', '--stdio' },
--     filetypes = { 'dockerfile', 'yaml',},
--     init_options = {
--         telemetry = "off",
--         dockercomposeExperimental = {
--             composeSupport = true,
--         }
--     }
-- }
-- vim.lsp.enable('docker-language-server')
