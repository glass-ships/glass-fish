#!/usr/bin/env fish
set DIR (dirname (status --current-filename))
####################################

###  Options etc.

# force command-line password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

### Scripts and Env

source $DIR/secrets.fish || true

### Aliases and functions

for file in $DIR/functions/*
    if test $file != $DIR"/functions/fish_prompt.fish"
        source $file
    end
end

#
set -e DIR
####################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/glass/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

