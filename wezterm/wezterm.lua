local wezterm = require 'wezterm';
local mux = wezterm.mux
local config = {}

wezterm.on('gui-startup', function(cmd)
    --   local tab, pane, window = mux.spawn_window(cmd or {})
    --   -- Create a split occupying the right 1/3 of the screen
    --   pane:split { size = 0.3 }
    --   -- Create another split in the right of the remaining 2/3
    --   -- of the space; the resultant split is in the middle
    --   -- 1/3 of the display and has the focus.
    --   pane:split { size = 0.5 }
end)




wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    local zoomed = ''
    if tab.active_pane.is_zoomed then
        zoomed = '[Z] '
    end

    local index = ''
    if #tabs > 0 then
        index = string.format('[%d/%d][%s] ', tab.tab_index + 1, #tabs, pane.domain_name)
    end

    return zoomed .. index .. tab.active_pane.title
end)

wezterm.on('format-tab-title', function(tab)
    local pane = tab.active_pane
    local title = pane.title
    if pane.domain_name then
        title = title .. ' - (' .. pane.domain_name .. ')'
    end
    return title
end)


return {
    font_size = 10,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    default_cursor_style = "BlinkingUnderline",
    cursor_blink_rate = 800,
    warn_about_missing_glyphs = false,
    enable_wayland = true,
    color_scheme = "Catppuccin Mocha",
    window_background_opacity = 0.9,
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.8,
    },
    visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
    },
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },
    launch_menu = {
        {
            label = "htop",
            args = { "htop" },
        },

    },
    -- window_frame = {
    --     inactive_titlebar_bg = "#353535",
    --     active_titlebar_bg = "#2b2042",
    --     inactive_titlebar_fg = "#cccccc",
    --     active_titlebar_fg = "#ffffff",
    --     inactive_titlebar_border_bottom = "#2b2042",
    --     active_titlebar_border_bottom = "#2b2042",
    --     button_fg = "#cccccc",
    --     button_bg = "#2b2042",
    --     button_hover_fg = "#ffffff",
    --     button_hover_bg = "#3b3052",
    -- },
    keys = {
        -- Turn off the default CMD-m Hide action, allowing CMD-m to
        -- be potentially recognized and handled by the tab
        { key = "r", mods = "CTRL|ALT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "d", mods = "CTRL|ALT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "x", mods = "CTRL|ALT", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
        { key = "t", mods = "CTRL|ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "t", mods = "CTRL|ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "w", mods = "CTRL|ALT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },

    },
    unix_domains = {
        {
            name = "unix",
        },
        {
            name = "midiatve",
        }
    },
}
