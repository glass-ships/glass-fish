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


### Cloudflare stuff

function update-cloudflared -d "update cloudflared"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
end

