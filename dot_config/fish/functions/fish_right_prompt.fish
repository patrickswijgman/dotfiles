function fish_right_prompt
    set milliseconds $CMD_DURATION
    set seconds (math -s 1 "$milliseconds / 1000")
    set minutes (math -m floor "$seconds / 60")
    set remain (math -m floor "$seconds % 60")

    set_color --dim white
    echo -n "󰔛 "

    if test $seconds -ge 1
        if test $minutes -ge 1
            echo -n -s $minutes m $remain s " "
        else
            echo -n -s $seconds s " "
        end
    else
        echo -n -s $milliseconds ms " "
    end

    set time (date +%T)
    set_color --dim white
    echo -n "󰅐 $time"

    set_color normal
end
