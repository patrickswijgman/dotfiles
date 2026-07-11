config.load_autoconfig(False)

### Appearance

config.source("themes/gruvbox-material.py")
config.set("tabs.position", "top")
config.set("tabs.padding", {"top": 5, "right": 10, "bottom": 5, "left": 10})
config.set("tabs.indicator.width", 0)

### Settings

config.set("auto_save.session", True)
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("content.fullscreen.overlay_timeout", 0)
config.set("content.fullscreen.window", True)
config.set("input.insert_mode.auto_enter", True)
config.set("input.insert_mode.auto_leave", False)
config.set("input.insert_mode.auto_load", True)
config.set("input.insert_mode.leave_on_load", False)
config.set("scrolling.smooth", True)

### Keybindings

config.bind("gJ", "tab-move +")
config.bind("gK", "tab-move -")
config.bind("gm", "tab-move")
config.unbind("q")

### Ad blocker

config.set("content.blocking.enabled", True)
config.set("content.blocking.method", "both")
config.set(
    "content.blocking.adblock.lists",
    [
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    ],
)

### Permissions

config.set("content.javascript.clipboard", "access")
config.set("content.notifications.enabled", False)
config.set("content.notifications.presenter", "libnotify")

# Google Calendar
config.set("content.notifications.enabled", True, "https://calendar.google.com")
config.set("content.register_protocol_handler", True, "https://calendar.google.com")

### User agents

# Slack
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0",
    "https://*.slack.com/*",
)

# Google login
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0",
    "https://accounts.google.com/*",
)
