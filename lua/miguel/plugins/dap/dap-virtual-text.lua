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

                --
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
                    local val = string.gsub(variable.value, "%s+", " ")
                    return '■ '..val
                end
            end,
        }
    end
}
