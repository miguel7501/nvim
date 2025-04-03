return {
    "benlubas/molten-nvim",
    dependencies = "3rd/image.nvim",
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_output_virt_lines = true
    end
}

-- -- testing
-- local molten = require("molten.status")
-- vim.print(molten.all_kernels())
