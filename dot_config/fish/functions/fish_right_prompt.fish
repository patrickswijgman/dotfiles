function fish_right_prompt
    set last_status $status

    if test $last_status -gt 0
        set_color red
        echo -n "󰰲 $last_status "
    end

    set milliseconds $CMD_DURATION
    set seconds (math -s 1 "$milliseconds / 1000")
    set minutes (math -s 0 "$seconds / 60")
    set remain (math -s 0 "$seconds % 60")

    set_color --dim white
    echo -n "󰔛 "

    if test $seconds -ge 1
        if test $minutes -ge 1
            echo -n -s $minutes m " " $remain s
        else
            echo -n -s $seconds s
        end
    else
        echo -n -s $milliseconds ms
    end

    set_color normal
end
