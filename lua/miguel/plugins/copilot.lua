return {
    "github/copilot.vim",
    cond = function ()
        return vim.system({"which", "wslview"}):wait().code == 0
    end,
    config = function ()
        vim.g.copilot_filetypes = {
            ["*"] = false,
            ["python"] = true,
            ["javascript"] = true,
            ["typescript"] = true,
            ["svelte"] = true,
            ["mysql"] = true,
            ["sql"] = true,
        }
    end
}
