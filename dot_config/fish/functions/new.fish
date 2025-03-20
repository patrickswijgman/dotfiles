function new
    set path $argv[1]

    if string match -q '*/' $path
        mkdir -p $path
        echo "Directory created: $path"
    else
        mkdir -p (dirname $path)
        touch $path
        echo "File created: $path"
    end
end
