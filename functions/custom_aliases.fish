#!/usr/bin/env fish

### General aliases

alias ll='ls -al1vF'
alias env='env | sort'          # sorted env
alias pls='sudo -E'             # sudo with user's env vars
alias howbig='du -csh $argv'    # check a folder size
alias upd='sudo apt update -y && sudo apt full-upgrade -y'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'


### Python/Poetry aliases

alias wpy='which python'
alias poetry-clear='poetry cache clear _default_cache --all ;; poetry cache clear PyPI --all'
alias jlab='jupyter lab --no-browser' # start jupyter lab


### Git aliases

alias gs='git status'
alias gco='git checkout'
alias gadd='git add -A'
alias gcam='git commit -am'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gstash='git stash'
alias gpop='git stash pop'
alias gsl='git stash list'
alias grpo='git remote prune origin'


### Docker aliases

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'
alias docker-rm-containers='docker rm (docker ps -a -q)'


### GCP aliases

alias gcssh='gcloud compute ssh'


### misc chains and aliases

alias get-spotify-playlists="cd ~/dev/spotipy-stuff ;; poetry -C ~/dev/DISCORD/compass-bot run python scripts/download_spotify_playlists.py -u oceanblocker ;; cd -" 
alias install-rust="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
alias vscode='/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'
alias ssh-compass='ssh root@146.190.220.140'
alias update-compass='cd ~/compass-bot/ ;; poetry run compass stop ;; git pull ;; poetry run compass -v start'
