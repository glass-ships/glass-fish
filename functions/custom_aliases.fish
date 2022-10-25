#!/usr/bin/env fish

### General aliases

alias ll='ls -al1vF'

alias env='env | sort'       # sorted env

alias pls='sudo -E'          # sudo with user's env vars

alias howbig='du -csh $argv' # check a folder size

# update apt packages
alias upd='sudo apt update -y && sudo apt full-upgrade -y' 

alias jlab='jupyter lab --no-browser' 

### Git aliases

alias gs='git status'

### Docker aliases

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'
alias docker-rm-containers='docker rm (docker ps -a -q)'

### misc chains and functions

alias vscode='/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'
alias discord-env='source ~/dev/DISCORD/discord-env/bin/activate.fish'
alias ssh-compass='ssh root@146.190.220.140'

### TISLab aliases
alias koza-env='source ~/dev/TISLAB/koza/koza-env/bin/activate.fish'
alias ingest-env='source ~/dev/TISLAB/monarch-ingest/ingest-env/bin/activate.fish'
