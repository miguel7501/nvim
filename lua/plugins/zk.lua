return {
    "zk-org/zk-nvim",
    config = function()
        require("zk").setup({
            picker = "telescope"
        })
        --NOTE docs are at https://github.com/zk-org/zk-nvim
        vim.keymap.set('n', '<leader>np', '<cmd>ZkNotes<cr>')
        vim.keymap.set('n', '<leader>pn', '<cmd>ZkNotes<cr>')
        vim.keymap.set('n', '<leader>nc', '<cmd>ZkNew<cr>')
        vim.keymap.set('n', '<leader>ni', '<cmd>ZkIndex<cr>')
        vim.keymap.set('n', '<leader>nt', '<cmd>ZkTags<cr>')
        vim.api.nvim_set_keymap("n", "<leader>ng",
            "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Grep notes> ') } }<CR>",
            { noremap = true, silent = false })
    end
}
