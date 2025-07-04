set fish_greeting

abbr zed zeditor

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

abbr yolo 'git commit --amend --no-edit && git push -f'

abbr dcu 'docker compose up'
abbr dcr 'docker compose run --rm'

abbr ns 'nix-shell --run fish'
abbr nr 'sudo nixos-rebuild switch --flake ~/nix#default'

abbr venv 'source .venv/bin/activate.fish'

abbr tr 'tree --gitignore --dirsfirst'

oh-my-posh init fish --config ~/.config/oh-my-posh/config.json | source
