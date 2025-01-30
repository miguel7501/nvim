return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons", { "echasnovski/mini.icons", opts = {} } },
    config = function()
        local oil = require("oil")
        oil.setup {
            default_file_explorer = true,
            columns = {
                "icon",
                "size",
            },
            delete_to_trash = true,
            watch_for_changes = true,
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["gp"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
        }
        -- Open Oil with preview enabled
        vim.api.nvim_create_autocmd("User", {
            pattern = "OilEnter",
            callback = function(args)
                local bufnr = vim.api.nvim_get_current_buf()
                if args.data.buf == bufnr then
                    local callback = oil.open_preview
                    vim.api.nvim_buf_call(bufnr, callback)
                    return true
                end
            end,
        })
    end
}
