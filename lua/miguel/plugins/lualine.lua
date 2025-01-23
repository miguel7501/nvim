return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')
        -- SpinnerCounter = 0
        -- local function lspspinner()
        --     local status = vim.lsp.status()
        --     if not status then
        --         return nil
        --     end
        --     local spinner = "─╲│╱"
        --     -- ⣶⣧⣏⡟⠿⢻⣹⣼
        --     -- if SpinnerCounter == 0 then spinner = "⣶"; SpinnerCounter = 1 end
        --     -- if SpinnerCounter == 1 then spinner = "⣧"; SpinnerCounter = 2 end
        --     -- if SpinnerCounter == 2 then spinner = "⣏"; SpinnerCounter = 3 end
        --     -- if SpinnerCounter == 3 then spinner = "⡟"; SpinnerCounter = 0 end
        --     print("This is lspspinner and this is the return value:")
        --     print( status )
        --     return status
        -- end
        lualine.setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 50,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diagnostics', { 'filename', path = 1 }, },
                lualine_c = {
                    -- { 'filename', path = 1 },
                    -- { 'buffers',  show_filename_only = true, }

                    -- { function()
                    --     return require'dap'.status()
                    -- end
                    -- },
                    { require'dap'.status }

                },
                -- lualine_x = { 'searchcount', 'encoding', 'fileformat', 'filetype' },
                lualine_x = { 'filetype' },
                -- lualine_x = { lspspinner }, -- lualine says something about invalid characters and shits itself
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'progress' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 }, require'dap'.status },
                lualine_x = { 'filetype' },
                lualine_y = { 'location'},
                lualine_z = { }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
            -- extensions = { 'nvim-dap-ui' }
        }
    end
}
