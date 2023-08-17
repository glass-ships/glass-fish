#!/usr/bin/env fish

### General aliases

alias ll='ls -al1vF'
alias env='env | sort'       # sorted env
alias pls='sudo -E'          # sudo with user's env vars
alias howbig='du -csh $argv' # check a folder size

alias upd='sudo apt update -y && sudo apt full-upgrade -y' 

alias jlab='jupyter lab --no-browser' 

### Git aliases

alias gs='git status'
alias gco='git checkout'
alias gadd='git add -A'
alias gcam='git commit -am'
alias gba='git branch -a'
alias gbd='git branch -d'
# alias git-cleanup-branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-cleanup-branches='git branch --merged main | grep -v "^[ *]*main$" | xargs git branch -d'

### Docker aliases

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'
alias docker-rm-containers='docker rm (docker ps -a -q)'

### GCP aliases

alias gcssh='gcloud compute ssh'

### misc chains and aliases

alias poetry-clear='poetry cache clear _default_cache --all ;; poetry cache clear PyPI --all'
alias install-rust="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
alias vscode='/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'
alias discord-env='source ~/dev/DISCORD/compass-bot/.venv/bin/activate.fish'
alias ssh-compass='ssh root@146.190.220.140'
