local wezterm = require 'wezterm'

local status_bar = require 'status_bar'
local tab_title = require 'tab_title'
local ai = require 'ai'

local config = wezterm.config_builder()

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

config.notification_handling = 'AlwaysShow'

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

wezterm.on('augment-command-palette', function(window, pane)
    return {
        {
            brief = 'Rename tab',
            icon = 'md_rename_box',

            action = act.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },
        {
            brief = 'Prompt AI',
            icon = 'fa_magic',
            action = ai.prompt(),
        },
    }
end)

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Solarized Dark (Gogh)'
    else
        return 'Solarized Light (Gogh)'
    end
end

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    print("appearance: " .. appearance)
    print("scheme: " .. scheme)

    if overrides.color_scheme then
        print("color_scheme: " .. overrides.color_scheme)
    end
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
    end
end)


return config
