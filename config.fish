#!/usr/bin/env fish
set DIR (dirname (status --current-filename))

#####################
###  Options etc. ###
#####################

# Force command-line password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

umask 022

######################
### Env / Scripts  ###
######################

# Source secrets as env vars, if present
source $DIR/secrets.fish || true

# Enable conda for fish
#source ~/anaconda3/etc/fish/conf.d/conda.fish

### Poetry stuff
set -gx POETRY_HOME /opt/poetry
fish_add_path -agP /opt/poetry/bin
# poetry config virtualenvs.in-project true

# so poetry stops complaining about keyrings
set -gx PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring 

####################################
### Custom Aliases and Functions ###
####################################

for file in $DIR/functions/*
    if test $file != $DIR"/functions/fish_prompt.fish"
        source $file
    end
end

####################################
set -e DIR
