local wezterm = require 'wezterm'

local module = {}

-- Determine if a tab has unseen output since last visited
local function has_unseen_output(tab)
    if not tab.is_active then
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then return true end
        end
    end
    return false
end

function module.format(tab, tabs, panes, config, hover, max_width)
    local title = string.format("[%d]: %s ", tab.tab_index + 1, tab.active_pane.title)

    local color
    if tab.active_pane.title:sub(1, 1) == '!' then
        color = "Green"
    end
    if has_unseen_output(tab) then
        color = "Blue"
    end
    if color then
        return {
            { Foreground = { AnsiColor = color } },
            { Text = title },
        }
    end
    return title
end

return module
