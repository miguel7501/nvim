return {
    "3rd/image.nvim",
    lazy=true,
    config = function()
        require("image").setup { --TODO this bitch sometimes takes 5 seconds to start and only works sometimes, sometimes it takes 3 seconds to hide an image
            backend = "kitty",
            -- kitty_method = "unicode-placeholders",
            kitty_method = "normal",
            processor = "magick_cli",
            integrations = {
                markdown = {
                    enabled = true,
                    only_render_image_at_cursor = true,
                    floating_windows = true,
                    clear_in_insert_mode = true,
                }
            },
            max_width = 100,
            max_height = 30,
            max_width_window_percentage = math.huge, ---@diagnostic disable-line -- molten.nvim docs say I need this, math.huge works in nvim
            max_height_window_percentage = math.huge, ---@diagnostic disable-line -- molten.nvim docs say I need this, math.huge works in nvim
            window_overlap_clear_enabled = false,                                     -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
            editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = true,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened

        }
    end
}
