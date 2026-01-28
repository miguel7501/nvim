function Shadesofpurple()
        vim.cmd("syntax enable")
        vim.g.shades_of_purple_airline = 1
        vim.cmd.colorscheme("shades_of_purple")
        vim.api.nvim_set_hl(0, "Keyword", { fg = "#FF9D00" })
        vim.api.nvim_set_hl(0, "Function", { fg = "#FAD000" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1E1E3F" })
        vim.api.nvim_set_hl(0, "MatchParen", { bg = "#856e00" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#232344" })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#292949" })

        vim.api.nvim_set_hl(0, "LocalHighlight2", { bg = "#3a376f" })

        vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#6084f9" })
        vim.api.nvim_set_hl(0, "NvimDapVirtualTextError", { fg = "#f96092" })
        vim.api.nvim_set_hl(0, 'CustomDapBg', {bg="#4C3D4E"}) -- this is used in ../after/init.lua:4

        vim.api.nvim_set_hl(0, "CustomUnusedVars", { undercurl = true, })
        vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "CustomUnusedVars" })

        vim.api.nvim_set_hl(0, "DiffAdd", {bg="#384d3c"})
        vim.api.nvim_set_hl(0, "DiffChange", {bg="#37346a"})
        vim.api.nvim_set_hl(0, "diffText", {bg="#37346a", underline = true, sp="#FF9D00"})
        vim.api.nvim_set_hl(0, "DiffDelete", {bg="#5a3d3d"})

        -- copilot. By default, both of those link to Comment
        -- CopilotSuggestion xxx links to Comment
        -- CopilotAnnotation xxx links to Comment
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#5555FF", italic = true })
        vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "", italic = true })


        vim.api.nvim_set_hl(0,  "@function.builtin.lua", {link="Function"}) -- this is too obvious to be the default
        -- disable LSP highlighting for some stuff so treesitter takes over
        vim.api.nvim_set_hl(0, "@lsp.type.property.lua", {})
        vim.api.nvim_set_hl(0,  "@lsp.type.comment.lua", {}) -- required for proper coloring of luadoc
        vim.api.nvim_set_hl(0, "@lsp.type.parameter.python", {})
        vim.api.nvim_set_hl(0, "@lsp.type.variable.python", {})
        vim.api.nvim_set_hl(0, "@lsp.type.property.python", {})
        vim.api.nvim_set_hl(0, "@lsp.type.function.lua", {}) --TODO this one seems to get overriden by something
        vim.api.nvim_create_autocmd("LspTokenUpdate", {          -- this is for python constants
            callback = function(args)
                local token = args.data.token
                -- print("This is LspTokenUpdate. args: ")
                -- print(vim.inspect(args))
                if not token.type == "variable" or not token.modifiers.readonly then
                    return nil
                end
                local text_table = vim.api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
                local text = table.concat(text_table)
                if text ~= string.upper(text) then -- python constants are always uppercase
                    return nil
                end
                vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "Constant")
            end
        })

end

return {
    "Rigellute/shades-of-purple.vim",
    dependencies = {"ribru17/bamboo.nvim", "ellisonleao/gruvbox.nvim"},
    config = function()
        Shadesofpurple()
    end
}
