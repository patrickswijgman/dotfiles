function dotlink --description "Symlink ~/dotfiles into home directory"
    set repo $HOME/dotfiles
    set ignore .git README.md

    set fd_args --base-directory $repo --type file --hidden
    for pattern in $ignore
        set fd_args $fd_args --exclude $pattern
    end

    echo "Applying dotfiles:"

    for file in (fd $fd_args)
        set src $repo/$file
        set dst $HOME/$file

        mkdir -p (dirname $dst)
        ln -sf $src $dst

        echo $src "→" $dst
    end
end

if not status is-interactive
    dotlink
end
