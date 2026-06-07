function fish_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showstashstate true

    set -g __fish_git_prompt_char_stateseparator ''
    set -g __fish_git_prompt_char_cleanstate ''
    set -g __fish_git_prompt_char_dirtystate '󰲶'
    set -g __fish_git_prompt_char_invalidstate '󰲶'
    set -g __fish_git_prompt_char_stagedstate '󰐕'
    set -g __fish_git_prompt_char_stashstate '󰏗'
    set -g __fish_git_prompt_char_untrackedfiles '󰝒'
    set -g __fish_git_prompt_char_upstream_ahead '󰁝'
    set -g __fish_git_prompt_char_upstream_behind '󰁅'
    set -g __fish_git_prompt_char_upstream_diverged '󰹹'

    set -g __fish_git_prompt_color_dirtystate red
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_stagedstate green
    set -g __fish_git_prompt_color_untrackedfiles red
    set -g __fish_git_prompt_color_stashstate magenta
    set -g __fish_git_prompt_color_upstream red

    set pwd (set_color blue)'󰉋' (prompt_pwd --dir-length=0)
    set git (set_color brblue)'󰘬' (fish_git_prompt '%s')
    set end (set_color white)'󰈺'

    echo $pwd $git $end (set_color --reset)
end
