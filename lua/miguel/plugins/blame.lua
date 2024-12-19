return {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
        require('blame').setup {
            date_format = "%d.%m.%Y",
            virtual_style = "right_align",
            merge_consecutive = false,
            mappings = {
                commit_info = "i",
                stack_push = "<TAB>",
                stack_pop = "<BS>",
                show_commit = "<CR>",
                close = { "<esc>", "q" },
            },
        }
    end,
}
