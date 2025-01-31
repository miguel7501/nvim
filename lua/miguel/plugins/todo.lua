return {
    "folke/todo-comments.nvim",
    -- TODO test comment
    -- HACK test comment
    -- NOTE test comment
    -- FIX test comment
    -- PERF test comment
    -- WARNING test comment
    opts = {
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*]],
            comments_only = true,
        },
        search = {
            pattern = [[.*<(KEYWORDS)\s*]],
        }

    }
}
