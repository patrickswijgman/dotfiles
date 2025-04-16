function fish_prompt
    if test -n "$IN_NIX_SHELL"
        set_color cyan
        echo -n "󱄅 $IN_NIX_SHELL "
    end

    if test -n "$VIRTUAL_ENV"
        set_color cyan
        echo -n "󰌠 $(basename $VIRTUAL_ENV) "
    end

    set cwd (prompt_pwd --dir-length=0)
    set_color blue
    echo -n "󰝰 $cwd "

    set is_inside_git_dir (git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n "$is_inside_git_dir"
        set is_dirty (git status --porcelain)

        if test -n "$is_dirty"
            set_color yellow
        else
            set_color green
        end

        if test -d .git/rebase-merge -o -d .git/rebase-apply
            set commit (git rev-parse --short HEAD)
            echo -n "󱓎 rebase ($commit) "
        else
            set branch (git symbolic-ref --short HEAD 2>/dev/null)
            echo -n "󰘬 $branch "
        end

        if test -n "$is_dirty"
            echo -n "󰤌 "
        end
    end

    set_color normal
    echo -n "󰈺 "
end
