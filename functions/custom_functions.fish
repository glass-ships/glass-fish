#!/usr/bin/env fish

function cs -d "cd and ls (with auto conda activation)"
    cd $argv[1]
    ls -al
end

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

### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
end
