return {
    "tummetott/reticle.nvim",
    config = function()
        local reticle = require("reticle")
        reticle.setup()
        reticle.set_cursorline(true)
        return {}
    end
}
