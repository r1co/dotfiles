local wezterm = require 'wezterm';

local customTheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
customTheme.background = "#000000"

return {
    color_schemes = {
        ["WezTheme"] = customTheme,
      },
    font_size = 10,
    font = wezterm.font('JetBrains Mono', {italic = false, harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'}}),
    default_cursor_style = "BlinkingUnderline",
    cursor_blink_rate = 800,

    warn_about_missing_glyphs = false,
    color_scheme =  "Catppuccin Mocha",
    window_background_opacity = 1.0,
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
        left = 10, right = 10,
        top = 10, bottom = 10,
    },

    launch_menu = {
        {
            label = "htop",
            args = {"htop"},
        },

    },

    window_frame = {
        -- inactive_titlebar_bg = "#353535",
        -- active_titlebar_bg = "#2b2042",
        -- inactive_titlebar_fg = "#cccccc",
        -- active_titlebar_fg = "#ffffff",
        -- inactive_titlebar_border_bottom = "#2b2042",
        -- active_titlebar_border_bottom = "#2b2042",
        -- button_fg = "#cccccc",
        -- button_bg = "#2b2042",
        -- button_hover_fg = "#ffffff",
        -- button_hover_bg = "#3b3052",
    },
    keys = {
        -- Turn off the default CMD-m Hide action, allowing CMD-m to
        -- be potentially recognized and handled by the tab
        {key = "r", mods = "CTRL|ALT", action = wezterm.action{SplitHorizontal = {domain = "CurrentPaneDomain"}}},
        {key = "d", mods = "CTRL|ALT", action = wezterm.action{SplitVertical = {domain = "CurrentPaneDomain"}}},
        {key = "x", mods = "CTRL|ALT", action = wezterm.action{CloseCurrentPane = {confirm = true}}},

        {key = "t", mods = "CTRL|ALT", action = wezterm.action{SpawnTab = "CurrentPaneDomain"}},
        {key = "t", mods = "CTRL|ALT", action = wezterm.action{SpawnTab = "CurrentPaneDomain"}},
        {key = "w", mods = "CTRL|ALT", action = wezterm.action{CloseCurrentTab = {confirm = true}}},

    },
    unix_domains = {
        {
            name = "unix",
        }},
    }

   