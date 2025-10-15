set fish_greeting

set -x FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --color=border:#6c7086,label:#cdd6f4"

abbr lg lazygit
abbr ld lazydocker

abbr gb 'git branch'
abbr gc 'git switch'
abbr ga 'git add .'
abbr gs 'git status'
abbr gst 'git stash -u'
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
abbr gdh 'git diff HEAD'
abbr gr 'git rebase -i'
abbr grc 'git rebase --continue'
abbr gra 'git rebase --abort'
abbr grs 'git restore'
abbr grss 'git restore --staged'
abbr grsm 'git restore --source origin/main'
abbr yolo 'git commit --amend --no-edit && git push --force'
abbr yeet 'git commit --amend --no-edit --no-verify && git push --force --no-verify'

abbr dcu 'docker compose up'
abbr dcr 'docker compose run --rm'

abbr ns 'nix-shell --run fish'
abbr nr 'sudo nixos-rebuild switch --flake ~/nix#default'

abbr tr 'tree --gitignore --dirsfirst'

abbr venv 'source .venv/bin/activate.fish'
abbr venvd 'source .venv/bin/deactivate.fish'

oh-my-posh init fish --config ~/.config/oh-my-posh/config.json | source

fzf --fish | source

