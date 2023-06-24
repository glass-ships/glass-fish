#!/usr/bin/env fish

function cs -d "cd and ls"
    cd $argv[1]
    ls -al
end


function move -d "mv, create dir if DNE"
    mkdir -p $argv[3]
    mv $argv[2] $argv[3]
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
                echo -------------------------
                echo $repo
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

### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
end

