#### Options etc.

# force command-line password entry 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

#### Aliases and functions
### general cli
alias ll='ls -alF'

alias env='env | sort'

alias please='sudo -E'

alias howbig='du -csh $argv'

alias upd='sudo apt update -y && sudo apt dist-upgrade -y'

### git
alias gs='git status'

### docker
alias docker-rm-containers='docker rm (docker ps -a -q)'

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'

alias build-cdms='bash $HOME/dev/cdms-jupyterlab/build.sh'

alias centroot='docker run --rm -it -v ~/.ssh:/home/eris/.ssh:ro -p 8888:8888 glasslabs/centroot:0.5'

### misc chains and functions

alias cleanup="bash -c 'rm -rf **/*~ **/__pycache__ build dist *.egg-info awkward1/*.so **/*.pyc'"

alias cmake-try='cd build ;; rm -rf ./* ;; cmake .. ;; make'

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

# build cpp (with awkward)
function gpp-awk
  g++ -I/opt/awkward-1.0/include -L/opt/awkward-1.0/build/lib.linux-x86_64-3.7/awkward1 $argv[1] -lawkward-static -lawkward-cpu-kernels-static -o $argv[2]
end

# rebuild kaitai-struct-compiler
function build-ksc
  cd ~/dev/awkward-kaitai/kaitai_struct_compiler
  if sbt compilerJVM/debian:packageBin
    pls dpkg -i ~/dev/awkward-kaitai/kaitai_struct_compiler/jvm/target/kaitai-struct-compiler_0.9-SNAPSHOT_all.deb
  else
    echo 'ksc failed to compile!'
  end
  cd -
end

######
source /opt/anaconda3/etc/fish/conf.d/conda.fish
conda activate base
