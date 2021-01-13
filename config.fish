########################
####  Options etc.  ####
########################

# force command-line password entry 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

##################################
#### Scripts and Env          ####
##################################

#source /opt/anaconda3/etc/fish/conf.d/conda.fish
#conda activate base

####################################
#### Aliases and functions      ####
####################################

### general cli

alias ll='ls -alF'

alias env='env | sort'

alias please='sudo -E'

alias howbig='du -csh $argv'

alias upd='sudo apt update -y && sudo apt dist-upgrade -y'

### git

alias gs='git status'

alias bfg='java -jar /home/glass/dev/bfg-1.13.1.jar'

### docker

alias docker-rm-containers='docker rm (docker ps -a -q)'

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

alias build-cdms='bash $HOME/dev/cdms-jupyterlab/build.sh'

alias centroot='docker run --rm -it -v ~/.ssh:/home/loki/.ssh:ro -p 8888:8888 glasslabs/centroot:0.5'

### misc chains and functions

alias cleanup="bash -c 'rm -rf **/*~ **/__pycache__ build dist *.egg-info awkward1/*.so **/*.pyc'"

alias cmake-try='cd build ;; rm -rf ./* ;; cmake .. ;; make'
