## Aliases and functions
alias ll='ls -alF'

alias env='env | sort'

alias gs='git status'

alias pls='sudo -E'

alias buildcdms='bash packages/cdms-jupyterlab/build.sh'

alias howbig='du -csh $argv'
alias upd='sudo apt update -y && sudo apt dist-upgrade -y'
alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

function cs 
    cd $argv[1] 
    ls -al
end

function move
    mkdir -p $argv[2]
    mv $argv[1] $argv[2]
end

## Options etc.

set -e SSH_ASKPASS
set -e GIT_ASKPASS

source  /opt/anaconda3/etc/fish/conf.d/conda.fish
