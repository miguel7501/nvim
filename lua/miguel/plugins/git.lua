return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        local gitsigns = require("gitsigns") --TODO figure out how to make the gitsigns trouble thing load the buffers properly even when previewing
        gitsigns.setup{
            on_attach = function(bufnr)
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                -- vim.print("This is gitsigns on_attach callback. Bufnr, bufname: ",bufnr, bufname)
                if bufname:match[[*.ipynb]] then
                    return false
                end
                return true
            end,
            vim.api.nvim_create_autocmd(
                "BufEnter",
                {
                    group = vim.api.nvim_create_augroup("group1", { clear = false }),
                    pattern = { "gitsigns://*" },
                    callback = function(args)
                        vim.bo.modifiable = false
                    end
                }
            )
        }
    end
}
