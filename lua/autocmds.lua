
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt_local.formatoptions:remove("o") -- this get overriden per ft and idk what does it
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yoinking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yoink', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc= "Remove trailing whitespace on save",
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function(args)
        vim.wo.wrap = true
    end
})
