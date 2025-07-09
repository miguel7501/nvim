return {}
-- this causes importErrors when I try to run tests. 


-- return {
--     "nvim-neotest/neotest",
--     dependencies = {
--         "nvim-neotest/nvim-nio",
--         "nvim-lua/plenary.nvim",
--         "antoinemadec/FixCursorHold.nvim",
--         "nvim-treesitter/nvim-treesitter",
--         "nvim-neotest/neotest-python",
--     },
--     config = function()
--         require("neotest").setup({
--             adapters = {
--                 require("neotest-python")({
--                     dap = { justMyCode = false },
--                     runner = "pytest",
--                     python = ".venv/bin/python",
--                     -- pytest_discover_instances = true,
--                 })
--             }})
--     end
-- }
