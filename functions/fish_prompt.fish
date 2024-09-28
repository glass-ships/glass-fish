# Customize FISH Prompt
function fish_prompt
    # remove welcome message
    set -U fish_greeting
    # $status gets nuked as soon as something else is run, e.g. set_color
    # so it has to be saved asap.
    set -l last_status $status

    ### Git stuff
    set normal (set_color normal)
    set magenta (set_color magenta)
    set yellow (set_color yellow)
    set green (set_color green)
    set red (set_color red)
    set gray (set_color -o black)

    # Fish git prompt
    set -g __fish_git_prompt_showdirtystate yes
    set -g __fish_git_prompt_showstashstate yes
    set -g __fish_git_prompt_showuntrackedfiles yes
    set -g __fish_git_prompt_showupstream yes
    set -g __fish_git_prompt_color_branch yellow
    set -g __fish_git_prompt_color_upstream_ahead green
    set -g __fish_git_prompt_color_upstream_behind red

    # Status Chars
    set -g __fish_git_prompt_char_dirtystate '⚡'
    set -g __fish_git_prompt_char_stagedstate '→'
    set -g __fish_git_prompt_char_untrackedfiles '☡'
    set -g __fish_git_prompt_char_stashstate '↩'
    set -g __fish_git_prompt_char_upstream_ahead '+'
    set -g __fish_git_prompt_char_upstream_behind -

    # set some colors
    set -g PURPLE (set_color 8D3AF2)
    set -g BLUE (set_color 4F81FF)
    set -g GREEN (set_color 31FA3A)
    set -g YELLOW (set_color F2E03A)
    set -g CYAN (set_color 34FFF3)
    set -g PINK (set_color FF34DD)
    set -g WHITE (set_color FFFFFF)
    set -g ce (set_color $fish_color_error)

    # Clear the line because fish seems to emit the prompt twice,
    # i.e. the initial display, then when you press enter.
    printf "\033[K"

    ### construct prompt
    # timestamp 
    # printf "$PURPLE\n["(date "+$YELLOW%H:%M")"$PURPLE]"
    printf "$PURPLE\n["(date "+$YELLOW%Y-%m-%d %H:%M")"$PURPLE]"
    # current dir
    printf "%s$WHITE" (pwd | sed "s,/,$YELLOW/$CYAN,g")
    # git status
    printf (__fish_git_prompt)
    # user and host in a fish
    printf "\n$PINK><$CYAN"(whoami)"$PINK@$CYAN"(hostname)"$PINK> "

    set_color normal
end
