#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Shorten cwd: replace $HOME with ~
home="$HOME"
short_cwd="${cwd/#$home/\~}"

# Git branch (skip optional locks)
git_branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

# Build output
# ANSI: blue=34, brblue=94, reset=0
output=""

# cwd in blue
output+="$(printf '\033[34m%s\033[0m' "$short_cwd")"

# git branch in bright blue
if [ -n "$git_branch" ]; then
  output+=" $(printf '\033[94m%s\033[0m' "$git_branch")"
fi

# model (no color)
output+=" $model"

# context usage if available
if [ -n "$used_pct" ]; then
  output+=" ctx:$(printf '%.0f' "$used_pct")%"
fi

# rate limit rolling windows if available
if [ -n "$five_hour_pct" ]; then
  output+=" 5h:$(printf '%.0f' "$five_hour_pct")%"
fi
if [ -n "$seven_day_pct" ]; then
  output+=" 7d:$(printf '%.0f' "$seven_day_pct")%"
fi

printf '%s' "$output"
