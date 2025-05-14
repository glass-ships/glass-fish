#!/usr/bin/env fish

#---------#
# General #
#---------#

abbr -a env 'env | sort' # sorted env
abbr -a grep 'grep -n' # always grep with line numbers
abbr -a sfind 'sudo find / -name' # find search entire filesystem
abbr -a pls 'sudo -E' # sudo with user's env vars
abbr -a howbig 'du -csh' # check a folder size
abbr -a res 'echo $status' # echo the last command's exit status
abbr -a upd 'sudo apt update -y && sudo apt full-upgrade -y'

#------------#
# Navigation #
#------------#

abbr -a ll 'ls -al1vF --color=auto'
abbr -a dev 'cd ~/dev'
abbr -a -- - 'cd -'
# abbr -a -- - 'cd $OLDPWD'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a ...... 'cd ../../../../..'

#---------------------#
# Python/Poetry/Conda #
#---------------------#

abbr -a wpy 'which python'
abbr -a pyver 'python --version'

abbr -a poetry-clear 'poetry cache clear _default_cache --all ;; poetry cache clear PyPI --all'
# abbr -a jlab 'jupyter lab --no-browser' # start jupyter lab

#-----#
# Git #
#-----#

abbr -a gs 'git status'
abbr -a gss 'git status -sb'
abbr -a glc 'git ls-files | xargs wc -l'
abbr -a glog 'git log --oneline --graph --decorate --all'

abbr -a gsb 'git switch'
abbr -a gco 'git checkout'
abbr -a gpull 'git pull'
abbr -a gadd 'git add -A'
abbr -a gcam 'git commit -am'
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'

abbr -a gstash 'git stash'
abbr -a gspop 'git stash pop'
abbr -a gsl 'git stash list'
abbr -a grpo 'git remote prune origin'

#--------#
# Docker #
#--------#

abbr -a docker-cleanup 'docker rmi (docker images -f "dangling=true" -q)'
abbr -a docker-rm-containers 'docker rm (docker ps -a -q)'
# sudo docker rm -v $(sudo docker ps -a -q -f status=exited)
# sudo docker rmi -f  $(sudo docker images -f "dangling=true" -q)
# docker volume ls -qf dangling=true | xargs -r docker volume rm


#-----#
# GCP #
#-----#

# abbr -a gcssh 'gcloud compute ssh'


#------#
# Misc #
#------#

abbr -a install-bun "curl -fsSL https://bun.sh/install | bash"
abbr -a install-pixi "curl -fsSL https://pixi.sh/install.sh | bash"
abbr -a install-rust "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
abbr -a install-uv "wget -qO- https://astral.sh/uv/install.sh | sh"

abbr -a vscode '/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'

abbr -a get-spotify-playlists 'cd ~/dev/_scripts/spotipy-stuff ;; uv run python scripts/download_spotify_playlists.py ;; cd -'

abbr -a ssh-compass 'ssh root@$COMPASS_IP'
abbr -a update-compass 'cd ~/compass-bot/ ;; uv run compass stop ;; git pull ;; uv run compass -v start'
