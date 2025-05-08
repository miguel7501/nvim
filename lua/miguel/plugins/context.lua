return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        local context = require("treesitter-context")
        context.setup{
            max_lines = 4,
            multiwindow = true,
            multiline_threshold = 1,
            min_window_height = 15,
            mode = 'topline',
        }
    end
}
