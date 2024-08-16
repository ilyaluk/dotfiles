local wezterm = require 'wezterm'

local appearance = require 'appearance'
local status_bar = require 'status_bar'
local tab_title = require 'tab_title'

local config = wezterm.config_builder()

if appearance.is_dark() then
    config.color_scheme = 'Solarized Dark (Gogh)'
else
    config.color_scheme = 'Solarized Light (Gogh)'
end

config.font_size = 16
config.window_frame = {
    font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
    font_size = 11,
}
config.window_decorations = 'RESIZE'
config.adjust_window_size_when_changing_font_size = false

config.enable_scroll_bar = true
config.scrollback_lines = 100000

config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false

config.quit_when_all_windows_are_closed = false

config.set_environment_variables = {
    PATH = os.getenv('PATH') .. ':/opt/homebrew/bin'
}

local act = wezterm.action
config.keys = {
    { key = 'P',         mods = 'SUPER',     action = act.ActivateCommandPalette },
    { key = 'UpArrow',   mods = 'ALT|SHIFT', action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'ALT|SHIFT', action = act.ScrollToPrompt(1) },
    {
        key = ',',
        mods = 'SUPER',
        action = act.SpawnCommandInNewTab {
            cwd = wezterm.home_dir,
            args = { 'nvim', wezterm.config_file },
        },
    },
}

wezterm.on('update-status', status_bar.update_status)
wezterm.on('format-tab-title', tab_title.format)

return config
