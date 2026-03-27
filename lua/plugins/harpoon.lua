return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon"):setup()
        -- keymaps
        local harpoon = require("harpoon")
        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():add(); print("Harpoon added")
        end, { desc = "Harpoon: Add file" })
        vim.keymap.set('n', '<leader>hr', function()
            harpoon:list():remove(); print("Harpoon removed")
        end, { desc = "Harpoon: Remove file" })                                                                                        -- TODO figure out how to remove terminal buffers that I Ctrl+D'd from harpoon
        vim.keymap.set('n', '<leader>hh', require("functions").harpoon_toggle_telescope, { desc = "Harpoon: Toggle quick menu" })
        vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = "Harpoon: Go to file 1" })
        vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = "Harpoon: Go to file 2" })
        vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = "Harpoon: Go to file 3" })
        vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = "Harpoon: Go to file 4" })
        vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end, { desc = "Harpoon: Go to file 5" })
        vim.keymap.set('n', '<leader>6', function() harpoon:list():select(6) end, { desc = "Harpoon: Go to file 6" })
        vim.keymap.set('n', '<leader>7', function() harpoon:list():select(7) end, { desc = "Harpoon: Go to file 7" })
        vim.keymap.set('n', '<leader>8', function() harpoon:list():select(8) end, { desc = "Harpoon: Go to file 8" })
        vim.keymap.set('n', '<leader>9', function() harpoon:list():select(9) end, { desc = "Harpoon: Go to file 9" })
        vim.keymap.set('n', '[h', function() harpoon:list():prev({ ui_nav_wrap = true }) end,
            { desc = "Harpoon: Previous file" })
        vim.keymap.set('n', ']h', function() harpoon:list():next({ ui_nav_wrap = true }) end,
            { desc = "Harpoon: Next file" })
    end,
}
