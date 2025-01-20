return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path",   -- source for file system paths
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            sorting = {
                priority_weight = 2,
                comparators = {
                    function(entry1, entry2) -- this puts python arguments at the top. entry.kind is "variable" for those so we need to check for the equal sign at the end
                        local e1_is_argument = entry1.completion_item.label:match("=$")
                        local e2_is_argument = entry2.completion_item.label:match("=$")
                        if e1_is_argument and not e2_is_argument then
                            return true
                        elseif e2_is_argument and not e1_is_argument then
                            return false
                        end
                        return nil
                    end,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
            })
        })
    end
}
