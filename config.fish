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

alias ll='ls -al1vF'

alias env='env | sort' # sorted env

alias please='sudo -E' # sudo with user's env vars

alias howbig='du -csh $argv' # check a folder size

alias upd='sudo apt update -y && sudo apt dist-upgrade -y' # update apt packages

alias jlab='jupyter lab --no-browser' 

### git aliases

alias gs='git status'
alias ship='git add -A ;; git commit -am $argv ;; git push'

### docker aliases

alias docker-rm-containers='docker rm (docker ps -a -q)'

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

### misc chains and functions
#
alias vscode='/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'
alias discord-env='source ~/dev/discord-env/bin/activate.fish'

# TISLab aliases
alias koza-env='source ~/dev/tislab/koza/koza-env/bin/activate.fish'
alias monarch-env='source ~/dev/tislab/monarch-ingest/monarch-env/bin/activate.fish'

####################################
set -e DIR

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/glass/dev/google-cloud-sdk/path.fish.inc' ]; . '/home/glass/dev/google-cloud-sdk/path.fish.inc'; end
