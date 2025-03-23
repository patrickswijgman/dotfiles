function fish_prompt
    set last_status $status

    set cwd (prompt_pwd --dir-length=0)
    set_color blue
    echo -n " 󰝰 $cwd "

    set is_inside_git_dir (git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n "$is_inside_git_dir"
        set git_branch (git symbolic-ref --short HEAD)
        set is_dirty (git status --porcelain)

        if test -n "$is_dirty"
            set_color yellow
        else
            set_color green
        end

        echo -n "󰘬 $git_branch "
    end

    if test $last_status != 0
        set_color red
        echo -n "󰅗 "
    else
        set_color green
        echo -n "󰧚 "
    end

    set_color normal
end
