function dotlink --description "Symlink ~/dotfiles into home directory"
    set repo ~/dotfiles

    for src in (find $repo -not -path '*/.git/*' -type f | sort)
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
