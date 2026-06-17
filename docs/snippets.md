# Snippets

## Styling Sway

```
set $bg #000000
set $text #666666
set $active_bg #000000
set $active_text #ffffff
set $urgent_bg #000000
set $urgent_text #ff0000

title_align center
titlebar_padding 8 4
titlebar_border_thickness 2
default_border normal 2
default_floating_border normal 2

# Containers <title_border> <title_background> <title_text> <split_indicator> <border>
client.focused $active_bg $active_bg $active_text $active_bg $active_bg
client.focused_inactive $bg $bg $text $bg $bg
client.unfocused $bg $bg $text $bg $bg
client.urgent $urgent_bg $urgent_bg $urgent_text $urgent_bg $urgent_bg

bar {
  colors {
    # Bar
    statusline $active_text
    background $bg
    # Workspaces <border> <background> <text>
    focused_workspace $active_bg $active_bg $active_text
    inactive_workspace $bg $bg $text
    urgent_workspace $urgent_bg $urgent_bg $urgent_text
  }
}
```
