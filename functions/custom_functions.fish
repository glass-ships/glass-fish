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


### Python/Conda stuff

function venv_activate --on-variable PWD -d "activate conda env/venv on cd"
    if [ -f (pwd)/.condaconfig ]
        set -gx VENVDIR (pwd)
        conda activate (cat .condaconfig)
    else if [ -f (pwd)/.venv/Scripts/activate ]
        set -gx VENVDIR (pwd)
        source ./.venv/Scripts/activate
    else if [ -f (pwd)/.venv/bin/activate.fish ]
        set -gx VENVDIR (pwd)
        source ./.venv/bin/activate.fish
    # else if [ -f (pwd)/.mambaconfig ]
    #     set -gx VENVDIR (pwd)
    #     mamba activate (cat .mambaconfig)
    end
    if not [ (string match "*$VENVDIR*" (pwd)) ]
        set -e VENVDIR
        if type -q deactivate
            deactivate
        else if test -n "$CONDA_PYTHON_EXE"
            conda deactivate
        end
    end
end


function install-miniforge -d "install miniforge"
    # Install Miniforge
    wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-(uname)-(uname -m).sh
    bash Miniforge3-(uname)-(uname -m).sh
end


function uninstall-miniforge -d "uninstall miniforge"
    if not [ (count $argv) -eq 0 ] && [ $argv[1] = check ]
        conda init --reverse --dry-run
        return
    else
        conda init --reverse
    end
    set CONDA_BASE_ENVIRONMENT (conda info --base)
    echo "The next command will delete all files in {$CONDA_BASE_ENVIRONMENT}."
    set -l response (read -l -P "Continue? [y/n]")
    if not string match -q "y*" -- string lower $response
        echo "Aborting..."
        return
    end
    echo "Deleting {$CONDA_BASE_ENVIRONMENT}..."
    rm -rf {$CONDA_BASE_ENVIRONMENT}
    echo "{$HOME}/.condarc will be removed if it exists"
    rm -f "{$HOME}/.condarc"
    echo "{$HOME}/.conda and underlying files will be removed if they exist."
    rm -fr {$HOME}/.conda
    echo "Uninstall complete."
end
