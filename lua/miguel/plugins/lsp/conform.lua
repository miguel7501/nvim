return {
    "stevearc/conform.nvim",
    init = function()
        require("conform").setup {
            formatters_by_ft = {
                python = { "ruff_format", },
                lua = { lsp_format = "fallback" },
                sql = { "sqruff" }

            },
            format_on_save = {
                formatters = {"ruff_organize_imports"}
            }
        }
        require("conform").formatters.sqruff = {
            prepend_args = {"--config", "/home/miguel/.config/nvim/tool_configs/sqruff.sqruff"}
        }
    end
}
