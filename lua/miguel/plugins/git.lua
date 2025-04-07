return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        local gitsigns = require("gitsigns") --TODO figure out how to make the gitsigns trouble thing load the buffers properly even when previewing
        gitsigns.setup{
            on_attach = function (bufnr)
                if vim.api.nvim_buf_get_name(bufnr):match[[*.ipynb]] then
                    return false
                end
                return true
            end
        }
    end
}
