return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() --TODO get a proper fzf tiebreaker. I want the most recent files to be lower so I can kinda misuse it as harpoon
        -- local telescope_builtin = require('telescope.builtin')
        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopePreviewerLoaded",
            callback = function(args)
                vim.wo.wrap = true
            end
        })
    end,
}
