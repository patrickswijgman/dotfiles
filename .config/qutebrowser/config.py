config.load_autoconfig(False)

### Appearance

config.source('themes/gruvbox-material.py')

### Settings

c.auto_save.session = True
c.colors.webpage.preferred_color_scheme = "dark"
c.content.fullscreen.overlay_timeout = 0
c.content.fullscreen.window = True
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.auto_load = False
c.input.insert_mode.leave_on_load = True
c.scrolling.smooth = True

### Permissions

c.content.javascript.clipboard = "access"
c.content.notifications.enabled = False
c.content.notifications.presenter = "libnotify"

# Google Calendar
config.set('content.notifications.enabled', True, 'https://calendar.google.com')
config.set('content.register_protocol_handler', True, 'https://calendar.google.com')

### User agents

# Slack
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'https://*.slack.com/*')

# Google login
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'https://accounts.google.com/*')

# content.cookies.accept = all
# https://*.slack.com/*: content.cookies.accept = all
# content.fullscreen.overlay_timeout = 0
# content.fullscreen.window = true
# https://*.slack.com/*: content.headers.user_agent = Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0
# https://accounts.google.com/*: content.headers.user_agent = Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0
# content.javascript.clipboard = access
# content.notifications.enabled = false
# https://calendar.google.com: content.notifications.enabled = true
# content.notifications.presenter = libnotify
# https://calendar.google.com: content.register_protocol_handler = true
# content.unknown_url_scheme_policy = allow-all
