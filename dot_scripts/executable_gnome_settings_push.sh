#!/bin/sh

root=~/.local/share/chezmoi
file=$root/dot_config/gnome/settings.ini

dconf dump / > $file

cd $root

git add $file
git commit -m "chore: updated gnome settings"
git push
