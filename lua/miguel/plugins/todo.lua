return {
    "folke/todo-comments.nvim",
    -- TODO test comment
    -- todo don't write lowercase todo comments
    -- HACK test comment
    -- NOTE test comment
    -- BUG test comment
    -- PERF test comment
    -- WARNING test comment
    opts = {
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*]],
            comments_only = true,
            multiline = false,
        },
        search = {
            pattern = [[.*<(KEYWORDS)\s*]],
        }

    }
}
