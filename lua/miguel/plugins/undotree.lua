return {
    "mbbill/undotree",
    config = function()
        vim.cmd("set undofile")
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_ShortIndicators = 1
        vim.g.undotree_HighlightChangedText = 0
    end

}
