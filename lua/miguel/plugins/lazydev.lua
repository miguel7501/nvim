return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "nvim-dap-ui"
      },
    },
  },
  -- {
  --     "kikito/inspect.lua", -- this lets us print tables
  -- }
}
