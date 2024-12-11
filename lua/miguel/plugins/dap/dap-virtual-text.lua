return {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
        local vt = require("nvim-dap-virtual-text")
        vt.setup {
            -- only_first_definition = false,
            -- all_references = true,
            virt_text_pos = "eol",
            display_callback = function(variable, buf, stackframe, node, options)
                -- print("This is dap-virtual-text callback.")
                -- print("Variable:")
                -- print(vim.inspect(variable))
                -- print("\nbuf:")
                -- print(vim.inspect(buf))
                -- print("\nstackframe:")
                -- print(vim.inspect(stackframe))
                -- print("\nnode:")
                -- print(vim.inspect(node))
                -- print("\noptions:")
                -- print(vim.inspect(options))
                -- print("\n\n\n")
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.type
                else
                    -- return variable.type .. " " .. variable.name .. ' = ' .. string.sub(variable.value, 1, 40)
                    if string.len(variable.value) < 45 then
                        return variable.value
                    end
                    return string.sub(variable.value, 1, 40) .. '..'
                end
            end,
        }
    end
}
