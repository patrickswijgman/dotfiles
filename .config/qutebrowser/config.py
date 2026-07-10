config.load_autoconfig(False)

# Appearance

config.source('themes/gruvbox-material.py')

# Settings

c.auto_save.session = True
c.colors.webpage.preferred_color_scheme = "dark"
c.content.fullscreen.overlay_timeout = 0
c.content.fullscreen.window = True
c.scrolling.smooth = True

# Permissions

c.content.javascript.clipboard = "access"
c.content.notifications.enabled = False
c.content.notifications.presenter = "libnotify"

# Grant permissions to Google Calendar without prompting
config.set('content.notifications.enabled', True, 'https://calendar.google.com')
config.set('content.register_protocol_handler', True, 'https://calendar.google.com')
