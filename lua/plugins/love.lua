return {
    "S1M0N38/love2d.nvim",
    cmd = "LoveRun",
    opts = {
        output = false, -- disable floating stdout window
        lsp = false,
    },
    keys = {
        -- { "<leader>v",  desc = "LÖVE" },
        { "<leader>v", "<cmd>Love run<cr>", desc = "Run LÖVE" },
        -- { "<leader>vs", "<cmd>LoveStop<cr>", desc = "Stop LÖVE" },
    },
}
