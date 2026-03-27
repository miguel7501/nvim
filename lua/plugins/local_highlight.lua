return {
    'tzachar/local-highlight.nvim',
    config = function()
        require('local-highlight').setup {
            file_types = { 'python', 'lua' },
            hlgroup = "LocalHighlight2",
            animate = false,
            debounce_timeout = 250,
        }
    end
}
