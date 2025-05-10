return {
    "LunarVim/bigfile.nvim",
    config = function()
        require("bigfile").setup({
            filesize = 20,
            features = {
                "indent_blankline",
                "illuminate",
                "syntax",
                "vimopts"
            },
            pattern = function(bufnr, filesize_mb) ---@diagnostic disable-line unused-local
                local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                if not string.find("sql mysql", ft) then
                    return false
                end
                local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
                local max_line = 0
                for n, line in ipairs(file_contents) do
                    max_line = math.max(max_line, #line)
                end
                local result = max_line > 2000
                -- vim.print("Bigfile found sql. Returning " .. tostring(result))
                return result
            end,
        })
    end
}
