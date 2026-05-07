
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    root_markers = { '.git' },
})


vim.lsp.config['basedpyright'] = {
    cmd = { 'basedpyright-langserver', '--stdio', '--threads', '16'},
    filetypes = {'python'},
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


local lua_libs = { "?.lua", "?/init.lua", vim.env.VIMRUNTIME, }
local cwd = vim.fn.getcwd()
if cwd == vim.fn.expand("~/.config/nvim") then -- we are configuring nvim
    table.insert(lua_libs, vim.fn.stdpath("data") .. "/lazy")
end

vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = lua_libs,
            },
            workspace = {
                library = lua_libs,
            }
        }
    },
}


vim.lsp.enable('luals')

if not Sad then
    vim.lsp.enable("glsl_analyzer")
end

vim.lsp.enable('bashls')
vim.lsp.enable{ 'svelte' , "ts_ls"} -- ts_ls = typescript



vim.api.nvim_create_autocmd("LspAttach",
{
    -- pattern={"basedpyright"},
    callback=function(evt)
        local lsp_client = vim.lsp.get_client_by_id(evt.data.client_id)
        if lsp_client == nil then
            return nil
        end
        if not lsp_client:supports_method("textDocument/foldingRange") then
            return nil
        end
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.vim.lsp.foldexpr()'
        vim.opt_local.foldlevelstart=99
        vim.opt_local.foldlevel=99
    end
})
