#### Aliases and functions

## general
alias ll='ls -alF'

alias env='env | sort'

alias pls='sudo -E'

alias howbig='du -csh $argv'

alias upd='sudo apt update -y && sudo apt dist-upgrade -y'

## git
alias gs='git status'

## Docker
alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

alias centroot='docker run --rm -it -v ~/.ssh:$HOME/.ssh:ro -p 8888:8888 glasslabs/centroot:0.3'

## misc
alias clean-awk="bash -c 'rm -rf **/*~ **/__pycache__ build dist *.egg-info awkward1/*.so **/*.pyc'"

alias buildcdms='bash packages/cdms-jupyterlab/build.sh'

## move then ls
function cs 
    cd $argv[1] 
    pwd
    ls -al
end

## move, create directory if doesn't exist
function move
    mkdir -p $argv[2]
    mv $argv[1] $argv[2]
end

#### Options etc.

set -e SSH_ASKPASS
set -e GIT_ASKPASS

source /opt/anaconda3/etc/fish/conf.d/conda.fish
conda activate base
