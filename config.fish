#### Options etc.

# force command-line password entry 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

source /opt/anaconda3/etc/fish/conf.d/conda.fish
conda activate base

#### Aliases and functions

### general
alias ll='ls -alF'

alias env='env | sort'

alias pls='sudo -E'

alias howbig='du -csh $argv'

alias upd='sudo apt update -y && sudo apt dist-upgrade -y'

### git
alias gs='git status'

### Docker
alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

alias build-cdms='bash $HOME/dev/cdms-jupyterlab/build.sh'

alias centroot='docker run --rm -it -v ~/.ssh:$HOME/.ssh:ro -p 8888:8888 glasslabs/centroot:0.3'

### misc
alias build-test='rm -rf ./* ;; g++ -I/opt/awkward-1.0/include -L/opt/awkward-1.0/build/lib.linux-x86_64-3.7/awkward1 ../tests/test.cpp -lawkward-static -lawkward-cpu-kernels-static -o Test ;; ./Test'

alias build-cleanup="bash -c 'rm -rf **/*~ **/__pycache__ build dist *.egg-info awkward1/*.so **/*.pyc'"

alias cmake-try='cd build ;; rm -rf ./* ;; cmake .. ;; make'

# cd and ls
function cs
    cd $argv[1]
    pwd
    ls -al
end

# mv, create dir if DNE
function move
    mkdir -p $argv[2]
    mv $argv[1] $argv[2]
end

