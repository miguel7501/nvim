vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    root_markers = { '.git' },
})


vim.lsp.config['basedpyright'] = {
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
    cmd = { 'basedpyright-langserver', '--stdio'},
    filetypes = {'python'},
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
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff', false) -- ruff LSP is annoying, I just use it as formatter

-- TODO get lazydev working with this. Right now I don't even know why luals is starting at all
-- vim.lsp.config['luals'] = {
--     cmd = { 'lua-language-server' },
--     filetypes = { 'lua' },
--     -- root_dir = function (bufnr, callback) -- grok suggested this, maybe it's worth uncommenting
--     --     callback(vim.fn.stdpath('config'))
--     -- end,
--     settings = {
--         Lua = {
--             runtime = {
--                 version = 'LuaJIT',
--             },
--             workspace = {
--                 library = {
--                     vim.env.VIMRUNTIME
--                 }
--             }
--         }
--     },
-- }
-- vim.lsp.enable('luals')
