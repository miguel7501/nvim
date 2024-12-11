return {
    'numToStr/Comment.nvim',
    opts = {
        -- toggler = {
        --     line = "<C-/>"
        -- }
    },
    config = function()
        require("Comment").setup({
            opleader = {
                line = "<C-_>", -- this means Ctrl+Slash
            },
            toggler = {
                line = "<C-_>"
            }
        })
    end

}
