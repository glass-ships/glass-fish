#!/usr/bin/env fish

function trim -d "trim whitespace (leading and trailing only)"
    echo -n (string trim -r -l $argv)
end


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

### Git functions

function ship -d "git add, commit, push"
    git add -A
    git commit -am $argv
    git push
end

function pull-all -d "git pull all repos in specified dirs"
    set current_dir (pwd)
    for dir in $argv
        cd $dir
        echo \nPulling all repos in (pwd)...
        for repo in *
            if test -d $repo && test -d $repo/.git
                echo ————————————————————————————————————————
                echo Pulling $repo...
                cd $repo
                git pull
                cd ..
            end
        end
        echo \nFinished!
        if not test $dir = '.'
            cd $current_dir
        end
    end
    echo \n All done!
end

function git-cleanup-branches -d "git delete local branches not on remote"
    for branch in (git branch --merged main)
        set b (string trim -r -l $branch)
        if not string match -q "*main" $b
            git branch -d $b
        end
    end
end

function gl-clone -d "gitlab clone with personal token"
    set -l options o/ornl
    argparse $options -- $argv

    if set --query _flag_ornl
        set url "code.ornl.gov"
        set TOKEN $ORNL_PAT
    else
        set url "gitlab.com"
        set TOKEN $GITLAB_PAT
    end

    # check env for token
    if not set -q GITLAB_PAT
        echo "Please set the GITLAB_PAT variable"
        return
    end
    set -l org $argv[1]
    set -l repo $argv[2]
    # if directory provided, clone to it
    printf "Cloning $url/$org/$repo"
    if test -d $argv[3]
        git clone https://oauth2:$TOKEN@$url/$org/$repo $argv[3]
    else
        git clone https://oauth2:$TOKEN@$url/$org/$repo
    end
    set -e url
end

### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
end

### Conda stuff

function conda_activate --on-variable PWD -d "activate conda env"
    if [ -f (pwd)/.condaconfig ]
        set -gx CONDACONFIGDIR (pwd)
        conda activate (cat .condaconfig)
    end
    if not [ (string match "*$CONDACONFIGDIR*" (pwd)) ]
        set -e CONDACONFIGDIR
        conda deactivate
    end
end

function install-miniforge -d "install miniforge"
    # Install Miniforge
    wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-(uname)-(uname -m).sh
    bash Miniforge3-(uname)-(uname -m).sh
end

function uninstall-miniforge -d "uninstall miniforge"
    if not [ (count $argv) -eq 0 ] && [ $argv[1] = "check" ]
        conda init --reverse --dry-run
        return
    else
        conda init --reverse
    end
    set CONDA_BASE_ENVIRONMENT (conda info --base)
    echo The next command will delete all files in {$CONDA_BASE_ENVIRONMENT}.
    set -l response (read -l -P "Continue? [y/n]")
    if not string match -q "y*" -- string lower $response
        echo "Aborting..."
        return
    end
    echo Deleting {$CONDA_BASE_ENVIRONMENT}
    rm -rf {$CONDA_BASE_ENVIRONMENT}
    echo {$HOME}/.condarc will be removed if it exists
    rm -f "{$HOME}/.condarc"
    echo {$HOME}/.conda and underlying files will be removed if they exist.
    rm -fr {$HOME}/.conda
    echo "Uninstall complete."
end
