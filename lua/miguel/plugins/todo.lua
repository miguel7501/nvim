return {
    "folke/todo-comments.nvim",
    -- TODO test comment
    -- todo don't write lowercase todo comments
    -- HACK test comment
    -- NOTE test comment
    -- BUG test comment
    -- BROKEN
    -- TEST
    -- PERF test comment
    -- WARNING test comment
    -- we DONE did it
    opts = {
        keywords = {
            TODO = { icon = "T", color = "#88F2F0"},
            DONE = { icon = "", color = '#96ff8f' },
            WIP = { icon = "🔨", color = '#ff9d00' },
            FIX = { alt = { "BUG", "BROKEN", "FIXME" } },
            TEST = { icon = " ", color = '#ff9d00' },
            IMPORTANT = { icon = " ", color = '#ff0000' },
            TJA = {icon = "🤷", color="#fce094"},
        },
        merge_keywords = true,
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*]],
            comments_only = false,
            multiline = false,
        },
        search = {
            pattern = [[.*<(KEYWORDS)\s*]],
        }

    }
}


