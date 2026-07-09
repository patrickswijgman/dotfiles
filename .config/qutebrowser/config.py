config.load_autoconfig(False)

config.source('themes/gruvbox.py')

c.auto_save.session = True
c.colors.webpage.preferred_color_scheme = "dark"
c.content.fullscreen.overlay_timeout = 0
c.content.fullscreen.window = True
c.editor.command = ['xdg-terminal-exec', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']
c.scrolling.smooth = True
