return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope_builtin = require('telescope.builtin')
        -- local function project_files() -- TODO this is broken
        --     local opts = {} -- you can define your options here
        --     local is_git_repo = pcall(function() telescope_builtin.git_files(opts) end)
        --     if not is_git_repo then
        --         telescope_builtin.find_files(opts)
        --     end
        -- end

        -- vim.keymap.set('n', '<C-p>',
        --     "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--no-ignore', '-g', '!.git' }})<cr>",
        --     {})

        -- moved to keymap.lua
        -- vim.keymap.set('n', '<C-p>', function()
        --     require('telescope.builtin').find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
        -- end, {})
        -- vim.keymap.set('n', '<leader>f', function()
        --     require('telescope.builtin').find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '--no-ignore' } })
        -- end, {})
        -- vim.keymap.set('n', '<F37>', function() -- Ctrl Shift P, don't ask why windows terminal turns that into F37
        --     require('telescope.builtin').grep_string({ search = vim.fn.input("Search in files> ") })
        -- end)
        -- vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, {})
    end,
}
