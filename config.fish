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

source secrets.fish

####################################
#### Aliases and functions      ####
####################################

### general cli convenience functions

alias ll='ls -alF'

alias env='env | sort'

alias please='sudo -E'

alias howbig='du -csh $argv'

alias upd='sudo apt update -y && sudo apt dist-upgrade -y'

alias jlab='jupyter lab --no-browser'

### git

alias gs='git status'

alias bfg='java -jar /home/glass/dev/bfg-1.13.1.jar'

### docker

alias docker-rm-containers='docker rm (docker ps -a -q)'

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

alias centroot='docker run --rm -it -v ~/.ssh:/home/loki/.ssh:ro -p 8888:8888 glasslabs/centroot:0.5'

### misc chains and functions

alias cmake-try='cd build ;; rm -rf ./* ;; cmake .. ;; make'
