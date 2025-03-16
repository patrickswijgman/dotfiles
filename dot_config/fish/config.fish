set fish_greeting

alias lg lazygit

abbr gc 'git checkout'
abbr ga 'git add .'
abbr gs 'git status'
abbr gst 'git stash'
abbr gstp 'git stash pop'
abbr gm 'git commit -m'
abbr gma 'git commit --amend'
abbr gf 'git fetch'
abbr gp 'git pull'
abbr gP 'git push'
abbr gl 'git log'
abbr gd 'git diff'
abbr gr 'git rebase -i'
abbr grc 'git rebase --continue'
abbr gra 'git rebase --abort'
abbr grs 'git restore'
abbr grss 'git restore --staged'

abbr dcu 'docker compose up'
abbr dcr 'docker compose run --rm'

abbr ns 'nix-shell --run fish'

oh-my-posh init fish --config ~/.config/oh-my-posh/config.json | source
