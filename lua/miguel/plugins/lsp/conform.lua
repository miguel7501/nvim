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
                json = { "jq" },
                svelte = { lsp_format = "prefer" },
                javascript = { "prettier", lsp_format = "fallback" },
                typescript = { "prettier", lsp_format = "fallback" },
            },
        }
        require("conform").formatters.ruff_format = { prepend_args = { [[--config]], [[line-length=100]] } }
        require("conform").formatters.sqruff = {
            prepend_args = { "--config", vim.fn.stdpath("config") .. "/tool_configs/sqruff.sqruff" },
            require_cwd = false,
        }
        require("conform").formatters.prettier = { prepend_args = { [[--tabWidth=2]], [[--printWidth=200]] } }

        vim.api.nvim_create_autocmd(
            { "BufWritePre" },
            {
                pattern = {"*.svelte"},
                callback = function(args)
                    -- vim.print("BufWritePre called with ", args)
                    vim.lsp.buf.format()
                end
            }
        )
        vim.api.nvim_create_autocmd(
            { "BufWritePre" },
            {
                pattern = {"*.ts"},
                callback = function(args)
                    -- vim.print("BufWritePost called with ", args)
                    vim.cmd[[%!prettier --stdin-filepath %]]
                end
            }
        )


    end
}
