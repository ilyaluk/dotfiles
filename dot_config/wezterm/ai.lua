local wezterm = require 'wezterm'
local module = {}

function module.prompt()
    return wezterm.action.PromptInputLine {
        description = 'Enter your query',
        action = wezterm.action_callback(function(window, pane, line)
            window:toast_notification("wezterm", "Thinking...", nil, 1500)

            local success, stdout, stderr = wezterm.run_child_process {
                'security', 'find-generic-password', '-a', 'wezterm-openai-key', '-w',
            }

            if not success then
                window:toast_notification("wezterm error", "No OpenAI token", nil, 1500)
                wezterm.log_error("Failed to read OpenAI token from Keychain: " .. stderr)
                wezterm.log_error(
                    "Copy, then run `security add-generic-password -a wezterm-openai-key -s openai -w $(pbpaste)`")
                return
            end

            local key = stdout:gsub("\n", "")
            local system_prompt =
            [[You are a helpful assistant who is an expert in shell scripting languages.
            You must read users' input and interpret it a description for a short shell script that they want to write.
            You must return commands suitable for copy/pasting into zsh on macOS.
            Do NOT include commentary NOR Markdown triple-backtick code blocks as your whole response will be copied into users' terminal automatically.
            ]]

            success, stdout, stderr = wezterm.run_child_process {
                'curl', "https://api.openai.com/v1/chat/completions",
                '-H', 'Authorization: Bearer ' .. key,
                '--json', wezterm.json_encode({
                model = "gpt-4o",
                messages = {
                    { role = "system", content = system_prompt },
                    { role = "user",   content = line },
                } })
            }

            if not success then
                window:toast_notification("wezterm error", "Failed to query OpenAI API", nil, 1500)
                wezterm.log_error("failed to run curl: " .. stderr)
                return
            end

            local resp = wezterm.json_parse(stdout)

            if resp["error"] then
                window:toast_notification("wezterm error", "OpenAI API error", nil, 1500)
                wezterm.log_error("error: " .. resp["error"]["message"])
                return
            end

            local result = resp["choices"][1]["message"]["content"]

            local choices = {}
            for l in result:gmatch("([^\n]*)\n?") do
                table.insert(choices, {
                    label = wezterm.format {
                        { Foreground = { AnsiColor = "Red" } },
                        { Text = l },
                    },
                    id = "accept"
                })
            end
            table.insert(choices, {
                label = wezterm.format {
                    { Foreground = { AnsiColor = "Green" } },
                    { Text = "Reject" },
                }
            })

            window:perform_action(wezterm.action.InputSelector {
                title = "Confirm AI result",
                description = "Confirm AI result: Enter = accept, Esc = reject",
                choices = choices,
                action = wezterm.action_callback(function(window, pane, id, label)
                    if id == "accept" then
                        pane:send_paste(result)
                    end
                end),
            }, pane)
        end),
    }
end

return module
