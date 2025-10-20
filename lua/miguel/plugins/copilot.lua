return {
    "github/copilot.vim",
    cond = function ()
        return vim.fn.system("which wslview") ~= ""
    end,
    config = function ()
        vim.g.copilot_filetypes = {
            ["*"] = false,
            ["python"] = true,
            ["javascript"] = true,
            ["typescript"] = true,
            ["svelte"] = true,
        }
    end
}
