return {
    "Rigellute/shades-of-purple.vim",
    config = function()
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

        vim.api.nvim_set_hl(0, "@lsp.type.parameter.python", {}) -- disable LSP highlighting for variables so treesitter takes over
        -- The LSP still has other semantic tokens that will override treesitter
        -- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.python", { link = "constant" }) -- this will make constants red but also applies to @property methods like df.empty
        vim.api.nvim_create_autocmd("LspTokenUpdate", {
            callback = function(args)
                local token = args.data.token
                -- print("This is LspTokenUpdate. args: ")
                -- print(vim.inspect(args))
                if not token.type == "variable" or not token.modifiers.readonly then
                    return nil
                end
                local text_table = vim.api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line,
                    token.end_col, {})
                local text = table.concat(text_table)
                if text ~= string.upper(text) then
                    return nil
                end
                vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "Constant")
            end
        })
    end
}
