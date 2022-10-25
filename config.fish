#!/usr/bin/env fish
set DIR (dirname (status --current-filename))
####################################

###  Options etc.

# Force command-line password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

### Scripts and Env

# Enable conda for fish
source ~/anaconda3/etc/fish/conf.d/conda.fish

# Source secrets as env vars
source $DIR/secrets.fish || true

# so poetry stops complaining
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# Source custom aliases and functions
for file in $DIR/functions/*
    if test $file != $DIR"/functions/fish_prompt.fish"
        source $file
    end
end

####################################
set -e DIR
