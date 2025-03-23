function fish_prompt
    set last_status $status

    set white (set_color normal; set_color white)
    set red (set_color normal; set_color red)
    set green (set_color normal; set_color green)
    set blue (set_color normal; set_color blue)
    set yellow (set_color normal; set_color yellow)

    echo -n -s $blue " 󰝰 " (prompt_pwd --dir-length=0) " "

    set is_inside_git_dir (git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n "$is_inside_git_dir"
        set git_branch (git symbolic-ref --short HEAD 2>/dev/null)
        set is_dirty (git status --porcelain)

        if test -n "$is_dirty"
            set git_color $yellow
        else
            set git_color $green
        end

        echo -n -s $git_color "󰘬 " $git_branch " "
    end

    if test $last_status != 0
        echo -n -s $red "󰅗 "
    else
        echo -n -s $green "󰧚 "
    end

    set_color normal
end
