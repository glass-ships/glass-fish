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
  set __fish_git_prompt_showdirtystate 'yes'
  set __fish_git_prompt_showstashstate 'yes'
  set __fish_git_prompt_showuntrackedfiles 'yes'
  set __fish_git_prompt_showupstream 'yes'
  set __fish_git_prompt_color_branch yellow
  set __fish_git_prompt_color_upstream_ahead green
  set __fish_git_prompt_color_upstream_behind red
  
  # Status Chars
  set __fish_git_prompt_char_dirtystate '⚡'
  set __fish_git_prompt_char_stagedstate '→'
  set __fish_git_prompt_char_untrackedfiles '☡'
  set __fish_git_prompt_char_stashstate '↩'
  set __fish_git_prompt_char_upstream_ahead '+'
  set __fish_git_prompt_char_upstream_behind '-'
   
  # set some colors
  set -g cp (set_color 8D3AF2) # purple
  set -g c0 (set_color 4F81FF) # blue
  set -g c1 (set_color 31FA3A) # green
  set -g c2 (set_color F2E03A) # yellow
  set -g c3 (set_color 34FFF3) # cyan
  set -g c4 (set_color FF34DD) # pink
  set -g ce (set_color $fish_color_error)

  # Clear the line because fish seems to emit the prompt twice. The initial
  # display, then when you press enter.
  printf "\033[K"

  ### construct prompt
  # timestamp 
  printf "$cp\n\n["(date "+$c2%H:%M")"$cp]"
  # current dir
  printf (pwd | sed "s,/,$c2/$c3,g") 
  # git status
  printf "$c4%s" (__fish_git_prompt)
  # user and host in a fish
  printf "\n><$c3"(whoami)"$c4@$c3"(hostname)"$c4> "

  set_color normal
end

