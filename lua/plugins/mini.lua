-- if true then return {} end
return {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
        local spec_treesitter = require('mini.ai').gen_spec.treesitter
        vim.treesitter.query.get('lua', 'textobjects')
        require("mini.ai").setup({
            custom_textobjects = {
                f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
            }
        })
    end
}
