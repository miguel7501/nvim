return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", lazy = true, ft = { "sql", "mysql" } },
    },
    -- cmd = { --TODO do I need this? The docs mention it but teej doesn't have it
    --
    -- }
    init = function ()
        vim.g.db_ui_save_location = "~/credentials/db_ui" -- if you copy this, make sure to `chmod 700 -r ~/credentials`
    end
}
