function dotlink --description "Symlink ~/dotfiles into home directory"
    set repo ~/dotfiles
    set files (find $repo -not -path '*/.git/*' -type f | sort)

    for src in $files
        set rel (string replace "$repo/" "" $src)
        set dst "$HOME/$rel"

        mkdir -p (dirname $dst)
        ln -sf $src $dst

        echo $rel
    end
end

if not status is-interactive
    dotlink
end
