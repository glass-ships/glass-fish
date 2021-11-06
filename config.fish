#!/usr/bin/env fish
set DIR (dirname (status --current-filename))

########################
####  Options etc.  ####
########################

# force command-line password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

##################################
#### Scripts and Env          ####
##################################

# Uncomment and tweak to your anaconda3 installation if you have one
#source /opt/anaconda3/etc/fish/conf.d/conda.fish
#conda activate base

source $DIR/secrets.fish

####################################
#### Aliases and functions      ####
####################################

### general cli convenience functions

# cd and ls
function cs
  cd $argv[1]
  pwd
  ls -al
end

# mv, create dir if DNE
function move
  mkdir -p $argv[3]
  mv $argv[2] $argv[3]
end

alias ll='ls -alF'

alias env='env | sort' # sorted env

alias please='sudo -E' # sudo with user's env vars

alias howbig='du -csh $argv' # check a folder size

alias upd='sudo apt update -y && sudo apt dist-upgrade -y' # update apt packages

alias jlab='jupyter lab --no-browser' 

### git aliases

alias gs='git status'

### docker aliases

alias docker-rm-containers='docker rm (docker ps -a -q)'

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

# runs a CentOS with ROOT docker image. See https://gitlab.com/glass-ships/centroot for more information
alias centroot='docker run --rm -it -v ~/.ssh:/home/loki/.ssh:ro -p 8888:8888 glasslabs/centroot:0.5'

### misc chains and functions

# clean build dir and try again
alias cmake-try='cd build ;; rm -rf ./* ;; cmake .. ;; make'

set -e DIR
