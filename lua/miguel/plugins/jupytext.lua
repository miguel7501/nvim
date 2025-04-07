return {
    "goerz/jupytext.nvim",
    config = function ()
        require("jupytext").setup{
            -- format = "py", -- this has no cell separators, which kinda sucks. Not even extmarks.
            -- format = "markdown",
            format = "py:percent",
            filetype = require'jupytext'.get_filetype,
            new_template = require'jupytext'.default_new_template()
        }
    end
}
