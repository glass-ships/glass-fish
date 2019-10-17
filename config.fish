## Aliases and functions
alias ll='ls -alF'

alias env='env | sort'

alias gs='git status'

alias pls='sudo -E'

function cs 
    cd $argv && ls -al
end

## Options etc.

set -e SSH_ASKPASS
set -e GIT_ASKPASS

