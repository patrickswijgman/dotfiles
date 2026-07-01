function dotlink --description "Symlink ~/dotfiles into home directory"
    set repo $HOME/dotfiles
    set ignore .git README.md
    set delete $HOME/.config/nvim

    set fd_args --base-directory $repo --type file --type symlink --hidden
    for pattern in $ignore
        set fd_args $fd_args --exclude $pattern
    end

    echo "Deleting files and directories:"

    for path in $delete
        rm -rf $path
        echo $path
    end

    echo ""
    echo "Applying dotfiles:"

    for file in (fd $fd_args)
        set src $repo/$file
        set dst $HOME/$file
        mkdir -p (dirname $dst)
        ln -sf $src $dst
        echo $file
    end

    echo ""
    echo "Done!"
end

if not status is-interactive
    dotlink
end
