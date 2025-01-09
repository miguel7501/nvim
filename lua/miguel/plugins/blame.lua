return {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
        require('blame').setup { --TODO make the colors of authors/dates a gradient so I can see how recent something is at a glance
            date_format = "%d.%m.%Y", --TODO maybe also make the `git diff` a bit nicer
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
