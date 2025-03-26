function fish_prompt
    if test -n "$IN_NIX_SHELL"
        set_color cyan
        echo -n "<nix-shell> "
    end

    if test -n "$VIRTUAL_ENV"
        set_color cyan
        echo -n "<venv> "
    end

    set cwd (prompt_pwd --dir-length=0)
    set_color blue
    echo -n "$cwd "

    set is_inside_git_dir (git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n "$is_inside_git_dir"
        set git_branch (git symbolic-ref --short HEAD)
        set is_dirty (git status --porcelain)

        if test -n "$is_dirty"
            set_color yellow
        else
            set_color green
        end

        echo -n "$git_branch "

        if test -n "$is_dirty"
            echo -n "[+] "
        end
    end

    set_color normal
    echo -n "-> "
end
