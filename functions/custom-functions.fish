#!/usr/bin/env fish

# function trim -d "trim whitespace (leading and trailing only)"
#     echo -n (string trim -r -l $argv)
# end

function cs -d "cd and ls (with auto conda activation)"
    cd $argv[1]
    ls -al
end

function move -d "mv, create dir if DNE"
    set destination $argv[-1]
    set -l files $argv[1..-2]
    echo "Moving to $destination/:" (string join ', ' $files)
    if not test -d $destination
        mkdir -p $destination
    end
    mv $files $destination
end

function keep -d "rm all except"
    set -l files *
    for keeper in $argv
        set -l keeper (string trim -r -c / $keeper)
        if set -l index (contains -i -- $keeper $files)
            set -e files[$index]
        end
    end
    rm -rf $files
end

### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
end

### Python env stuff

# function venv_activate --on-variable PWD -d "activate virtual env on cd"
#     if [ -f (pwd)/.venv/Scripts/activate ]
#         set -gx VENVDIR (pwd)
#         source ./.venv/Scripts/activate
#     else if [ -f (pwd)/.venv/bin/activate.fish ]
#         set -gx VENVDIR (pwd)
#         source ./.venv/bin/activate.fish
#     else if [ -f (pwd)/.condaconfig ]
#         set -gx VENVDIR (pwd)
#         micromamba activate (cat .condaconfig)
#         source ./.venv/bin/activate.fish
#     else if [ -f (pwd)/.mambaconfig ]
#         set -gx VENVDIR (pwd)
#         mamba activate (cat .mambaconfig)
#     end
#     if not [ (string match "*$VENVDIR*" (pwd)) ]
#         set -e VENVDIR
#         if type -q deactivate
#             deactivate
#         else if test -n "$CONDA_PYTHON_EXE"
#             micromamba deactivate
#         end
#     end
# end
