return {
    "stevearc/conform.nvim",
    init = function()
        require("conform").setup {
            log_level = vim.log.levels.TRACE,
            formatters_by_ft = {
                python = { "ruff_format", "ruff_organize_imports" },
                lua = { lsp_format = "fallback" },
                sql = { "sqruff" },
                mysql = { "sqruff" },

            },
        }
        require("conform").formatters.ruff_format = { prepend_args = { [[--config]], [[line-length=100]] }}
        require("conform").formatters.sqruff = {
            prepend_args = { "--config", vim.fn.stdpath("config").."/tool_configs/sqruff.sqruff" },
            require_cwd = false,
        }
    end
}
