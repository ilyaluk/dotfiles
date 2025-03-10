# dotfiles

Loose collection of personal dotfiles and scripts, managed with chezmoi.

On a new mac:

```bash
# Sign in to Apple ID
# Set hostname in General->About and Sharing
# Allow full disk access for Terminal in Privacy and Security
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=$PATH:/opt/homebrew/bin
brew install chezmoi
chezmoi init --apply ilyaluk
```

Stuff to do manually-ish:

- Google account logins
- Enable Find My
- Mail/Calendar setup
- Add ssh key to Github/Gitlab
- Set up OpenAI tokens in iTerm, Zed and Raycast

Not automated yet, future work:

- Some app settings / `defaults`:
- - Enabled notifications
- - Telegram (doesn't use defaults)
- - Mullvad
- - Safari:
- - - enable extensions
- - - toolbar elements (OrderedToolbarItemIdentifiers)
- - Run adguard on login
- - Things hotkey + cloud login
- - Raycast extensions & prefs
- Cask for hyperswitch
- atuin history sync
- calendar in sketchybar
- openlens @alebcay/openlens-node-pod-menu
- Scripts installation
- - devbox non-interactive
- - rust non-interactive
- allow privacy permissions automatically
- Cache zsh completions by scripts, not hardcode
- remove all quarantines from installed apps
- keepass auto-open db form iCloud
- macOS status bar items
- screen lock time config
- Lunar auto-start, allow accesibilty
- Enable night shift
- mpv upscaler
- enable timeout for keyboard backlight, managed by CoreBrightness.framework
- setapp stuff
- bettertouchtool settings
