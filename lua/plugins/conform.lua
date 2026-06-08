return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                python = { "ruff_format" }
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        }
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
