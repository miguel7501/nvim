vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    root_markers = { '.git' },
})


vim.lsp.config['basedpyright'] = {
    cmd = { 'basedpyright-langserver', '--stdio'},
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
vim.lsp.enable('luals')

vim.lsp.enable('bashls')

vim.lsp.enable('svelte')
