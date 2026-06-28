function hyperfocus --description 'Lock screen after a while to break hyperfocus; restarts on unlock'
    while true
        sleep 30m
        playerctl pause
        swaylock
    end
end
