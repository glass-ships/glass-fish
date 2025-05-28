function ship -d "git add, commit, push"
    git add -A
    git commit -am $argv
    git push
end

function pull-all -d "git pull all repos in specified dirs"
    set current_dir (pwd)
    for dir in $argv
        cd $dir
        echo \n========================================
        echo Pulling all repos in (pwd)...
        for repo in *
            if test -d $repo && test -d $repo/.git
                cd $repo
                echo ————————————————————————————————————————
                echo Pulling $repo @ (git branch --show-current)...
                git pull
                cd ..
            end
        end
        echo ————————————————————————————————————————
        echo === Finished in (pwd) ===
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