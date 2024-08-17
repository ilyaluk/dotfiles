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
    local color

    local term_title = tab.active_pane.title
    if #tab.tab_title > 0 then
        term_title = tab.tab_title
        color = "Yellow"
    end
    local title = string.format("[%d]: %s ", tab.tab_index + 1, term_title)

    if term_title:sub(1, 1) == '!' then
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
