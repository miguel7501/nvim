return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup {
            on_attach = function(bufnr)
                vim.api.nvim_create_autocmd(
                    "BufEnter",
                    {
                        group = vim.api.nvim_create_augroup("group1", {}),
                        pattern = { "gitsigns://*" },
                        callback = function(args)
                            vim.bo.modifiable = false
                        end
                    }
                )

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                -- vim.print("This is gitsigns on_attach callback. Bufnr, bufname: ",bufnr, bufname)
                if bufname:match [[*.ipynb]] then
                    return false
                end
                return true
            end
        }
        -- Git
        vim.keymap.set('n', ']c', function() gitsigns.nav_hunk('next') end)
        vim.keymap.set('n', '[c', function() gitsigns.nav_hunk('prev') end)
        vim.keymap.set('n', '<leader>gd', function() gitsigns.diffthis(nil, { vertical = true, split = "belowright" }) end,
            { desc = "git diff" })
        vim.keymap.set('n', '<leader>ga', function() gitsigns.stage_hunk() end, { desc = "git add for the current change" })
        vim.keymap.set('n', '<leader>gt', function() gitsigns.setqflist('all') end,
            { desc = "Open all unstaged changes in Trouble" })
        vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk() end, { desc = "Preview current change" })
        vim.keymap.set('n', '<leader>B', '<cmd>BlameToggle<cr>', { desc = "Blame (from old plugin)" })
        vim.keymap.set('n', '<leader>gb', function() gitsigns.blame() end, { desc = "blame" })
        vim.keymap.set('n', '<leader>go', function()
            vim.cmd [[terminal lazygit]]
            vim.cmd [[startinsert]]
        end, { desc = "open lazygit" })
        --TODO map sgD to diff but with prompt for branch/commit instead of always doing HEAD

    end
}
