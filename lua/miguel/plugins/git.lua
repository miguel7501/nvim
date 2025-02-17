return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        local gitsigns = require("gitsigns") --TODO figure out how to make the gitsigns trouble thing load the buffers properly even when previewing
        gitsigns.setup()
    end
}
