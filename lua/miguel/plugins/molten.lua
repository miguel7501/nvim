return {
    "benlubas/molten-nvim",
    dependencies = "3rd/image.nvim",
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_output_virt_lines = true
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_crop_border = false
        vim.g.molten_output_win_style = "minimal"
        vim.g.molten_output_win_cover_gutter = false

        vim.api.nvim_create_autocmd(
            "User",
            {
                pattern = "MoltenKernelReady",
                callback = function()
                    local text = vim.api.nvim_buf_get_text(0, 0, 0, -1, -1, {})
                    local percent_cell_start = nil
                    for line, content in ipairs(text) do
                        if content == "# %%" then
                            if percent_cell_start then
                                vim.fn.MoltenDefineCell(percent_cell_start + 1, line - 1) -- excludes cell marker
                            end
                            percent_cell_start = line
                        elseif string.sub(content, 1, 3) == "# %%" then -- this means it's a markdown cell
                            percent_cell_start = nil
                        end
                    end
                end
            })
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*.ipynb",
            callback = function()
                if require('molten.status').initialized() ~= "" then
                    return nil
                end
                local kernelspec_json = vim.fn.system("jupyter kernelspec list --json")
                if vim.v.shell_error ~= 0 then
                    print("Error in `jupyter kernelspec list --json`")
                    return nil
                end
                local kernelspecs = vim.fn.json_decode(kernelspec_json).kernelspecs
                local basename = vim.fs.basename(vim.fn.getcwd())
                for kernel, _ in pairs(kernelspecs) do
                    if kernel == basename then
                        vim.cmd("MoltenInit " .. basename)
                        print("Molten Autoinit: You're welcome. I just saved you two keystrokes")
                        return nil
                    end
                end
                -- vim.print("Molten Autoinit: No matching kernel found. Basename: ",basename," Kernelspec: ", kernelspecs)
            end
        })
    end
}

-- -- testing
-- local molten = require("molten.status")
-- vim.print(molten.all_kernels())
