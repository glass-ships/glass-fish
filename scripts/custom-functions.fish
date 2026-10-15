#!/usr/bin/env fish

# function trim -d "trim whitespace (leading and trailing only)"
#     echo -n (string trim -r -l $argv)
# end

function cs -d "cd and ls (with auto conda activation)"
    cd $argv[1] || return 1
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

function upd-tools -d "update all tools (uv, pixi, bun, rustup)"
    echo "Updating uv..." && uv self update || echo "Failed to update uv"
    printf "\nUpdating pixi...\n" && pixi self-update || echo "Failed to update pixi"
    printf "\nUpdating bun...\n" && bun upgrade || echo "Failed to update bun"
    printf "\nUpdating rustup...\n" && rustup update || echo "Failed to update rustup"
end

function upd-vscode -d "Download latest VSCode and unpack to usual directory"
    cd ~/dev/bin/vscode
    keep data chrome-sandbox  # Clean up old files, keep data/ and chrome-sandbox
    wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -O vscode.tar.gz &&
        tar -xf vscode.tar.gz &&
        mv VSCode-linux-x64/* . &&
        rm -rf VSCode-linux-x64 vscode.tar.gz
    cd -
end    


### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    if type -q apt
        # Debian/Ubuntu
        wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
        sudo dpkg -i cloudflared-linux-amd64.deb
        rm cloudflared-linux-amd64.deb
    else if type -q pacman
        # Arch Linux
        wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
        chmod +x cloudflared-linux-amd64
        sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
    else
        echo "Unsupported distribution - please install cloudflared manually"
        return 1
    end
end

### Python env stuff

function venv_activate --on-variable PWD -d "activate virtual env on cd"
    if [ -f (pwd)/.venv/Scripts/activate ]
        set -gx VENVDIR (pwd)
        source ./.venv/Scripts/activate
    else if [ -f (pwd)/.venv/bin/activate.fish ]
        set -gx VENVDIR (pwd)
        source ./.venv/bin/activate.fish
    # else if [ -f (pwd)/.condaconfig ]
    #     set -gx VENVDIR (pwd)
    #     micromamba activate (cat .condaconfig)
    #     source ./.venv/bin/activate.fish
    # else if [ -f (pwd)/.mambaconfig ]
    #     set -gx VENVDIR (pwd)
    #     mamba activate (cat .mambaconfig)
    end
    if not [ (string match "*$VENVDIR*" (pwd)) ]
        set -e VENVDIR
        if type -q deactivate
            deactivate
        else if test -n "$CONDA_PYTHON_EXE"
            micromamba deactivate
        end
    end
end
