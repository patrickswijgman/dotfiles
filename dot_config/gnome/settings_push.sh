#!/bin/sh

file=~/.local/share/chezmoi/dot_config/gnome/settings.ini

dconf dump / > $file

git add $file
git commit -m "chore: updated gnome settings"
git push
