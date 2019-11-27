function fish_prompt
    # remove welcome message
    set -e fish_greeting
    # $status gets nuked as soon as something else is run, e.g. set_color
    # so it has to be saved asap.
    set -l last_status $status

    # set some colors
    set -g cp (set_color 8D3AF2) # 
    set -g c0 (set_color 4F81FF) # blue
    set -g c1 (set_color 31FA3A) # green
    set -g c2 (set_color F2E03A) # yellow
    set -g c3 (set_color 34FFF3) # cyan
    set -g c4 (set_color FF34DD) # pink
    set -g ce (set_color $fish_color_error)

    # Clear the line because fish seems to emit the prompt twice. The initial
    # display, then when you press enter.
    printf "\033[K"

    # time, pwd, prompt
    printf "$c4\n["; printf (pwd | sed "s,/,$c2/$c3,g") # | sed "s,\(.*\)/[^m]*m,\1/,")
    printf "$c4 ]"
    printf "\n"; printf "><" # (date "+$c0%H.%M.%S")
    printf $c3; printf (whoami); printf "$c4@"; printf $c3; printf (hostname)
    printf "$c4> "

    #printf "$c2\n["(date "+$c0%H.%M.%S")"]$c4["(pwd | sed "s,/,$c2/$c3,g")
    # | sed "s,\(.*\)/[^m]*m,\1/,")
    #printf "\n><"
    #printf $c3(whoami); printf "$c4@"; printf $c3; printf (hostname)
    #printf "$c4> "
end
