return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'abccsss/nvim-gitstatus'
    },
    config = function()
        local lualine = require('lualine')
        lualine.setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                -- component_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 50,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'diagnostics',
                    { 'filename', path = 1 },
                    -- { 'gitstatus', sections = { --TODO no worky
                    --     { "untracked", format = "{}+" },
                    --     { "modified",  format = "{}*" },
                    --     { "renamed",   format = "{}~" },
                    --     { "deleted",   format = "{}-" },
                    -- }, sep = " ",
                    -- }
                },
                lualine_c = {
                    { require 'dap'.status }

                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    'progress',
                    { 'tabs', tabs_color = { active = 'TabLineSel', inactive = 'TabLine' } }
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'progress' }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
            -- extensions = { 'nvim-dap-ui' }
        }
    end
}
