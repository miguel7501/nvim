return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "lua", "python", "markdown", "yaml", "toml", "xml", "ini", "csv", "comment", "sql", },
            auto_install = true,
            highlight = { enable = true },
            injections = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            rainbow = {
                enable = true,
                disable = { "html" },
                extended_mode = false,
                max_file_lines = nil,
            },
            sync_install = false,
            ignore_install = {},
        }
    end,
}
