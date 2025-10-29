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

vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        }
    },
}
vim.lsp.enable('lua_ls')

vim.lsp.enable('bashls')
vim.lsp.enable{ 'svelte' , "ts_ls"} -- ts_ls = typescript



vim.api.nvim_create_autocmd("LspAttach",
{
    -- pattern={"basedpyright"},
    buffer=0,
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
    end
})
