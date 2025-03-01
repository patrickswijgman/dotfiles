#!/bin/sh

file=~/.config/gnome/settings.ini

dconf load / < $file

