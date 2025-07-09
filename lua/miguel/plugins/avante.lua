return {
    "yetone/avante.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
        "saghen/blink.cmp",
        "nvim-tree/nvim-web-devicons",
    },
    build = "make",
    event = "VeryLazy",
    opts = {
        mode = "agentic",
        provider = "ollama",
        auto_suggestion_provider = nil,
        providers = {
            ollama = {
                endpoint = "http://192.168.108.78:11434",
                -- model = "qwen2.5-coder:latest", -- best so far but not great
                -- model = "gemma2:27b", -- slow and doesn't seem to understand tools
                -- model = "llama3.3:latest", --very slow, probably fills VRAM
                model = "deepseek-r1:32b", -- yet another new model
                disabled_tools = {"git_commit", "web_search"},
            }
        },
        hints = { enabled = false },
        windows = {
            sidebar_header = {
                enabled = false,
            },
            ask = {
                start_insert = false,
            }
        },
    }
}
