local M = {}

local conf = require("telescope.config").values
function M.harpoon_toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
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

-- function M.preserve_cursor(callback, callback_args)
--
--   -- Save the current cursor position and line content
--   local current_pos = vim.api.nvim_win_get_cursor(0) -- {line, col}
--   local current_line = vim.api.nvim_get_current_line()
--
--   -- Execute the callback
--   callback(callback_args)
--
--   -- Retrieve the buffer lines after the callback
--   local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--
--   -- Helper to search for the closest match
--   local function find_line_match(line)
--     for idx, buf_line in ipairs(buf_lines) do
--       if buf_line == line then
--         return idx
--       end
--     end
--     return nil
--   end
--
--   -- Try to find the exact match first
--   local match_line = find_line_match(current_line)
--
--   -- If exact match not found, progressively shorten and try again
--   local shortened_line = current_line
--   while not match_line and #shortened_line > 0 do
--     shortened_line = shortened_line:match("^(.*)%s+[^%s]*$") or ""
--     match_line = find_line_match(shortened_line)
--   end
--
--   -- Jump to the match if found, otherwise fallback to original position
--   if match_line then
--     vim.api.nvim_win_set_cursor(0, {match_line, 0})
--   else
--     vim.api.nvim_win_set_cursor(0, current_pos)
--   end
-- end
--
--
--

function M.preserve_cursor(callback, callback_args)
    local current_pos = vim.api.nvim_win_get_cursor(0) -- {line, col}
    local current_line = vim.api.nvim_get_current_line()

    callback(callback_args)

    local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local function find_line_match(line, start_line) -- Helper to search for the closest match, wrapping around if necessary
        local buf_len = #buf_lines
        for i = 0, buf_len - 1 do
            local idx = (start_line + i - 1) % buf_len + 1
            if buf_lines[idx] == line then
                return idx
            end
        end
        return nil
    end

    -- Try to find the exact match starting from the original line position
    local match_line = find_line_match(current_line, current_pos[1])

    -- If exact match not found, progressively shorten and try again
    local shortened_line = current_line
    while not match_line and #shortened_line > 0 do
        shortened_line = shortened_line:match("^(.*)%s+[^%s]*$") or ""
        match_line = find_line_match(shortened_line, current_pos[1])
    end

    -- Jump to the match if found, otherwise fallback to original position
    if match_line then
        vim.api.nvim_win_set_cursor(0, { match_line, 0 })
    else
        vim.api.nvim_win_set_cursor(0, current_pos)
    end
end

function M.get_visual_selection()
    local mode = vim.fn.mode(1)
    if not mode:match("[vV]") and not mode:match("CTRL-V") then
        return nil
    end
    local start = vim.fn.getpos("v")
    local stop = vim.fn.getpos(".")
    local text = vim.fn.getregion(start, stop)
    return table.concat(text, "\n")
end

-- test link https://python-poetry.org/history/

function M.gx(path) -- copy of vim.ui.open that can get the link under the cursor and has a high timeout because wslview is so slow
    path = M.get_visual_selection()
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
    return vim.system(
        cmd,
        { text = true, timeout = 10000, detach = true },
        function() vim.print("We back from wslview") end
    ), nil
end

M.dap_test_config = {
    justMyCode = false,
}

---@param bufnr number
---@return number | nil
-- Get the first window containing the given buffer
function M.buf_get_win(bufnr)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
            return win
        end
    end
    return nil
end

-- like standard `gF` but opens the file in another buffer.
-- If there's a text buffer on screen, it uses that.
-- If not, it opens a vertical split.
function M.gf()
    local cWORD = vim.fn.expand("<cWORD>")
    local filepath, line = string.match(cWORD, "([^:]+):(%d+)")
    if not (filepath and line) then
        filepath = vim.fn.expand('<cfile>')
    end
    if not filepath then
        return nil
    end
    -- vim.print("gf called. cWORD: " .. cWORD .. "  Filepath: " .. filepath .. "  Line: " .. tostring(line))
    -- Iterate through all windows in the current tabpage
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
        local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ''

        -- Check if the window has a normal text buffer and is not floating
        if buftype == '' and not is_floating then
            --TODO check if buffer is in another tab and if so, ignore it
            -- Open the file in this window without switching to it
            vim.api.nvim_win_call(winid, function()
                vim.cmd('edit ' .. filepath)
                if line then
                    local pos = { tonumber(line), 0 }
                    vim.print(pos)
                    local ok = pcall(vim.api.nvim_win_set_cursor, 0, pos)
                    if not ok then
                        vim.print("gf: Cursor position outside buffer")
                        vim.cmd [[:norm G]]
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

function M.vt()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        local bufname = vim.api.nvim_buf_get_name(buf)
        if not string.match(bufname, "^term://") then
            goto continue
        end
        local bufinfo = vim.fn.getbufinfo(buf)[1]
        -- vim.print("Bufinfo:")
        -- vim.print(bufinfo)
        if bufinfo.loaded == 0 then
            goto continue
        end
        if bufinfo.hidden == 1 then
            vim.cmd [[:vsplit]]
            vim.cmd(":buf " .. tostring(buf))
            return nil
        else
            local win = bufinfo.windows[1]
            if type(win) ~= "number" then
                vim.print("VT error: bufinfo.windows[1] is not a number. Type, value:  ", type(win), win) -- appears to happen when dapui is open
                vim.print("Bufinfo: ", bufinfo)
                return nil
            end
            -- vim.print("Switching to window "..tostring(win))
            vim.api.nvim_set_current_win(win)
            return nil
        end
        ::continue::
    end

    vim.cmd [[:vert :term]]
    return nil
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
    local lsp_client = vim.lsp.get_client_by_id(inlay_hints[1].client_id)
    vim.lsp.util.apply_text_edits(inlay_hints[1].inlay_hint.textEdits, inlay_hints[1].bufnr, "utf-8")
end

return M
