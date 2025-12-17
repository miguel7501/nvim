return {
    "S1M0N38/love2d.nvim",
    cmd = "LoveRun",
    opts = {},
    keys = {
        { "<leader>v",  desc = "LÖVE" },
        { "<leader>vv", "<cmd>LoveRun /home/miguel/projects/love2d_min/<cr>",  desc = "Run LÖVE" }, -- yes, it's a hack. No, I won't fix it.
        { "<leader>vs", "<cmd>LoveStop<cr>", desc = "Stop LÖVE" },
    },
}
