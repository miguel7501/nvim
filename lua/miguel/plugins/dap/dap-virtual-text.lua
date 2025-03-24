return {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
        local vt = require("nvim-dap-virtual-text")
        ---@diagnostic disable-next-line
        VTLOGFILE = ""
        vt.setup { ---@diagnostic disable-line:missing-fields
            -- only_first_definition = false,
            -- all_references = true,
            virt_text_pos = "eol",
            display_callback = function(variable, buf, stackframe, node, options)
                -- print("This is dap-virtual-text callback.")
                -- print("Variable:")
                -- print(vim.inspect(variable)) --TODO get corresponding buf line so we can fill the rest of it with vt
                -- print("\nbuf:")
                -- print(vim.inspect(buf))
                -- print("\nstackframe:")
                -- print(vim.inspect(stackframe))
                --
                -- if variable then
                --     VTLOGFILE = VTLOGFILE .. vim.inspect(node)
                -- end
                --
                -- print("\noptions:")
                -- print(vim.inspect(options))
                -- print("\n\n\n")
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.type
                else
                    return '■ '..variable.value

                    -- -- The code below cuts the virtual text so it doesn't cause line wraps. But at some point it started working without that code
                    -- local row = node:start()
                    -- local line = vim.api.nvim_buf_get_lines(buf, row, row+1, true)[1]
                    -- local win = require('miguel.misc').buf_get_win(buf)
                    -- if win == nil then
                    --     return "Error: win "..win.." is nil for variable "..variable.name
                    -- end
                    -- local width = vim.api.nvim_win_get_width(win)
                    -- local available_space = width - #line
                    -- vim.print("dapVT callback: Available space for line "..row.." is "..available_space..", variable.value is "..#variable.value.." chars long")
                    -- if #variable.value < available_space then
                    --     vim.print("dapVT callback: Returning "..variable.value)
                    --     return variable.value
                    -- end
                    -- local retval = string.sub(variable.value, 1, available_space-4) .. '..'
                    -- vim.print("dapVT callback: Returning "..retval)
                    -- return retval
                end
            end,
        }
    end
}
