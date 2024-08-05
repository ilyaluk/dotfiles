# dotfiles

Loose collection of personal dotfiles and scripts, managed with chezmoi.

On a new mac:
```bash
# Sign in to Apple ID
# Allow Terminal to control all apps in Privacy and Security
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
chezmoi init --apply ilyaluk
```

Not automated yet, future work:
* Per-device settings, e.g. email/disabling some apps
* Input switch by caps-lock
* Enable reduce motion in accessibility
* Enable Find My
* iTerm settings and profiles
* Some app settings / `defaults`:
* * Enabled notifications
* * First day of the week
* * Telegram
* * Mullvad
* * Stretchly
* * Slack settings
* * Safari:
* * * history expiration
* * * enabled extensions
* * * toolbar elements
* * Run adguard on login
* * Things hotkey + cloud login
* Cask for hyperswitch, and its configuration (keys, shift, bg, small icons, disable stats)
* Raycast settings export/import
* Open at Login items: safari, iterm, tg, things, music, mail
* Setting up mail/calendar
* atuin history sync
* OpenAI tokens in iTerm, Zed and Raycast

* calendar in sketchybar
* stretchly ignore in aerospace
* safari disable tab color
* openlens @alebcay/openlens-node-pod-menu
