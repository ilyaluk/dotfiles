local wezterm = require 'wezterm'

local appearance = require 'appearance'

local module = {}

-- Returns something like
--         "KeyboardLayout Name" = ABC;
local function get_input_name()
    local handle = io.popen('defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources')
    if not handle then
        return
    end

    local output = handle:read('*a')
    for line in output:gmatch('[^\r\n]+') do
        if line:find('KeyboardLayout Name') then
            return line
        end
    end
end

function module.update_status(window)
    -- segments_special contain segments that shown left to the rest of segments
    -- they have hardcoded colors, and mostly used for highlighting some special condition
    local segments_colored = {}

    local input = get_input_name()
    if input and input:find('Russian') then
        table.insert(segments_colored, {
            Text = 'RU',
            Background = { AnsiColor = 'Red' },
        })
    end

    local segments = {}

    local host = wezterm.hostname():gmatch('[^.]+')()
    table.insert(segments, host)

    local color_scheme = window:effective_config().resolved_palette
    local fg = color_scheme.foreground
    local bg = color_scheme.background

    -- Note the use of wezterm.color.parse here, this returns
    -- a Color object, which comes with functionality for lightening
    -- or darkening the colour (amongst other things).
    -- Each powerline segment is going to be coloured progressively
    -- darker/lighter depending on whether we're on a dark/light colour
    -- scheme. Let's establish the "from" and "to" bounds of our gradient.
    local gradient_to = wezterm.color.parse(bg)
    local gradient_from
    if appearance.is_dark() then
        gradient_from = gradient_to:lighten(0.2)
    else
        gradient_from = gradient_to:darken(0.2)
    end

    local gradient = wezterm.color.gradient(
        {
            orientation = 'Horizontal',
            colors = { gradient_from, gradient_to },
        },
        #segments -- only gives us as many colours as we have segments.
    )

    local status = {}
    table.insert(status, { Background = { Color = 'none' } })

    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local function add_seg(text, bg, fg)
        table.insert(status, { Foreground = bg })
        table.insert(status, { Text = SOLID_LEFT_ARROW })

        table.insert(status, { Background = bg })
        table.insert(status, { Foreground = fg })
        table.insert(status, { Text = ' ' .. text .. ' ' })
    end

    for _, seg in ipairs(segments_colored) do
        add_seg(seg.Text, seg.Background, { Color = fg })
    end
    for i, seg in ipairs(segments) do
        add_seg(seg, { Color = gradient[i] }, { Color = fg })
    end
    window:set_right_status(wezterm.format(status))
end

return module
