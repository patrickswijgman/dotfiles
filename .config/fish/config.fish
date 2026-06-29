# Disable default fish greeting
set fish_greeting

# Git abbreviations
abbr gb 'git branch'
abbr gc 'git switch'
abbr ga 'git add'
abbr gs 'git status'
abbr gst 'git stash'
abbr gsts 'git stash show'
abbr gstl 'git stash list'
abbr gstp 'git stash pop'
abbr gm 'git commit -m'
abbr gma 'git commit --amend'
abbr gman 'git commit --amend --no-edit'
abbr gf 'git fetch'
abbr gp 'git pull'
abbr gP 'git push'
abbr gl 'git log'
abbr gd 'git diff'
abbr gds 'git diff --staged'
abbr gdh 'git diff HEAD'
abbr gr 'git rebase -i'
abbr grc 'git rebase --continue'
abbr gra 'git rebase --abort'
abbr grs 'git restore'
abbr grss 'git restore --staged'
abbr grsm 'git restore --source origin/main'
abbr yolo 'git commit --amend --no-edit && git push --force'
abbr yeet 'git commit --amend --no-edit --no-verify && git push --force --no-verify'

# Docker abbreviations
abbr dcu 'docker compose up'
abbr dcr 'docker compose run --rm'

# NixOS abbreviations
abbr nsh 'nix-shell --run fish'
abbr ncg 'sudo nix-collect-garbage --delete-older-than 5d'
abbr nrs --set-cursor 'sudo nixos-rebuild switch --flake ~/nix#%'
abbr nrb --set-cursor 'sudo nixos-rebuild boot --flake ~/nix#%'
abbr npr --set-cursor 'nix run nixpkgs#%'

# Virtualenv abbreviations
abbr va 'source .venv/bin/activate.fish'
abbr vd 'source .venv/bin/deactivate.fish'

# Start SSH agent (reuse if already running)
keychain --quiet --quick
set keychain_file ~/.keychain/(hostname)-fish
if test -f $keychain_file
    source $keychain_file
end

# Enable FZF shell integrations
# <ctrl-r> search command history
# <ctrl-t> search file
# <alt-c> change directory
fzf --fish | source
