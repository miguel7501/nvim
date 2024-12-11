-- Plugin installation
require("lazy").setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",

    "Rigellute/shades-of-purple.vim",
    "vim-airline/vim-airline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp"
})

-- undotree
vim.cmd("set undofile")
vim.g.undotree_SetFocusWhenToggle = 1

-- LSP Stuff
local nvim_cmp = require('cmp')     -- autocomplete
nvim_cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args)
        end,
    }
})
require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")
lspconfig.basedpyright.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                logLevel = "Trace",
            }
        }
    } }
-- lspconfig.mypy.setup{} -- not in lspconfig yet, so we use basedpyright instead
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

