local M = {}
local function get_visual_selection()
    local mode = vim.fn.mode(1)
    if not mode:match("[vV]") and not mode:match("CTRL-V") then
        return nil
    end
    local start = vim.fn.getpos("v")
    local stop = vim.fn.getpos(".")
    local text = vim.fn.getregion(start, stop)
    return table.concat(text, "\n")
end
local function is_hidden_terminal(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if not string.match(bufname, "^term://") then
        return false
    end
    local bufinfo = vim.fn.getbufinfo(bufnr)[1]
    if bufinfo.loaded == 0 then
        return false
    end
    if bufinfo.hidden == 0 then
        return false
    end
    return true
end

-- opens a terminal in a vertical split, reusing an existing terminal buffer if possible
function M.vt()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        if is_hidden_terminal(buf) then
            vim.cmd [[:vsplit]]
            vim.cmd(":buf " .. tostring(buf))
            return nil
        end
    end
    vim.cmd [[:vert :term]] ---@diagnostic disable-line[unreachable-code]
    return nil
end

-- :term but reuses existing hidden terminals
function M.term()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        if is_hidden_terminal(buf) then
            vim.cmd(":buffer " .. tostring(buf))
            return nil
        end
    end
    vim.cmd[[:term]]

end


function M.harpoon_toggle_telescope()
    local conf = require("telescope.config").values
    local harpoon_list = require("harpoon"):list()
    local file_paths = {}
    if harpoon_list == nil or harpoon_list.items == nil then
        vim.print("Harpoon list is empty")
        return nil
    end

    for _, item in ipairs(harpoon_list.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

-- if there cursor is in front of an inlay hint, this function applies it
-- see `:h lsp-inlay_hint` for details (I also stole half the code from there)
function M.apply_inlay_hint()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local inlay_filter = {
        bufnr = 0,
        range = {
            start = { line = cursor_pos[1] - 1, character = cursor_pos[2] },
            ["end"] = { line = cursor_pos[1] - 1, character = math.huge },
        }
    }
    local inlay_hints = vim.lsp.inlay_hint.get(inlay_filter)
    if inlay_hints[1] == nil then
        vim.print("No inlay hints found after cursor")
        return nil
    end
    vim.lsp.util.apply_text_edits(inlay_hints[1].inlay_hint.textEdits, inlay_hints[1].bufnr, "utf-8")
end

function M.sad_gx(path) -- copy of vim.ui.open that can get the link under the cursor and has a high timeout because wslview literally takes 10 seconds to return even though it's async
    path = get_visual_selection()
    if not path then
        path = vim.fn.expand("<cWORD>")
    end
    vim.validate({ path = { path, 'string' }, })
    if path == "" then
        return nil
    end

    local is_uri = path:match('%w+:') --TODO check if path contains a URL. If so, strip anything other than the URL
    if not is_uri then
        path = vim.fs.normalize(path)
    end

    local cmd = { 'wslview', path } --- @type string[]
    print(cmd[1], cmd[2])
    local time_before_ns = vim.uv.hrtime() ---@diagnostic disable-line[undefined-field]
    return vim.system(
        cmd,
        { text = true, timeout = 10000, detach = true },
        function()
            local time_after_ns = vim.uv.hrtime() ---@diagnostic disable-line[undefined-field]
            local time_taken_ms = math.floor((time_after_ns - time_before_ns) / 1000000)
            vim.print("We back from wslview after "..tostring(time_taken_ms).."ms")
        end
    ), nil
end

-- like standard `gF` but opens the file in another buffer.
-- If there's a text buffer on screen, it uses that.
-- If not, it opens a vertical split.
function M.gf() --TODO :term may break filenames into multiple lines and that breaks this function
    local cWORD = vim.fn.expand("<cWORD>")
    local filepath, line = string.match(cWORD, "([^:]+):(%d+)")
    if not (filepath and line) then
        filepath = vim.fn.expand('<cfile>')
    end
    if not filepath then
        return nil
    end
    -- vim.print("gf called. cWORD: " .. cWORD .. "  Filepath: " .. filepath .. "  Line: " .. tostring(line))
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
        local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ''

        if buftype == '' and not is_floating then
            --TODO check if buffer is in another tab and if so, ignore it (for dadbod-ui tabs)
            vim.api.nvim_win_call(winid, function()
                vim.cmd('edit ' .. filepath)
                if line then
                    local pos = { tonumber(line), 0 }
                    vim.print(pos)
                    local ok = pcall(vim.api.nvim_win_set_cursor, 0, pos)
                    if not ok then
                        vim.print("gf: Cursor position outside buffer")
                        vim.cmd[[:norm G]]
                    end
                end
            end)
            return nil
        end
    end

    -- No suitable text buffer window found, create a new vertical split
    vim.cmd('vsplit ' .. filepath)
    if line then
        local pos = { tonumber(line), 0 }
        local ok = pcall(vim.api.nvim_win_set_cursor, 0, pos)
        if not ok then
            vim.print("gf: Cursor position outside buffer")
            vim.cmd [[:norm G]]
        end
    end
    return nil
end


return M
