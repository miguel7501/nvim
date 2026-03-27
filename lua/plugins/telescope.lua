return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("telescope").setup {
            defaults = {
                layout_config = { height = 0.99,
                    width = 0.9,
                    preview_width = 0.5,
                    -- mirror = true,
                },
                layout_strategy = "horizontal",
            }
        }
        local telbuiltin = require('telescope.builtin')
        local live_grep = function()
            telbuiltin.live_grep(
                { 'rg', '--no-config', '--files', '--hidden', '--no-ignore' })
        end
        local find_files = function()
            telbuiltin.find_files({ find_command = { 'rg', '--no-config', '--files', '--hidden', '-g', '!.git', } })
        end
        vim.keymap.set('n', '<C-p>', find_files, {})
        vim.keymap.set('n', '<C-S-P>', live_grep, { desc = "Live Grep" })
        vim.keymap.set('n', '<leader>pg', live_grep, { desc = "Live Grep" })
        vim.keymap.set('n', '<leader>ps', telbuiltin.lsp_workspace_symbols)
        vim.keymap.set('n', '<leader>pp', find_files)
        vim.keymap.set('n', '<leader>pk', "<cmd>Telescope keymaps<cr>")
        vim.keymap.set('n', '<leader>ph', "<cmd>Telescope help_tags<cr>")
        vim.keymap.set('n', '<leader>pB', "<cmd>Telescope builtin<cr>")
        vim.keymap.set('n', '<leader>pb', '<cmd>Telescope buffers<cr>')
        vim.keymap.set('n', '<leader>hh', require("functions").harpoon_toggle_telescope)

    end,
}
