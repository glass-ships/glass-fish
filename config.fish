#!/usr/bin/env fish
set DIR (dirname (status --current-filename))

#####################
###  Options etc. ###
#####################

# Force cmdline password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

umask 022

######################
### Env / Scripts  ###
######################

# Source secrets as env vars, if present
if test -e $DIR/secrets.fish
    source $DIR/secrets.fish
end

# Enable conda for fish, if present
if test -e ~/anaconda3/etc/fish/conf.d/conda.fish
    source ~/anaconda3/etc/fish/conf.d/conda.fish
end

### Poetry settings
set -gx POETRY_HOME /opt/poetry
fish_add_path -agP /opt/poetry/bin
poetry config virtualenvs.in-project true
set -gx PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring 

####################################
### Custom Aliases and Functions ###
####################################

for file in $DIR/functions/*.fish
    switch $file
    case $DIR"/functions/fish_prompt.fish"
        continue
    case $DIR"/functions/bass.fish"
        continue
    case "*"
        # echo "importing $file"
        source $file
    end
end

####################################

# Call load_nvm to listen on directory change
load_nvm > /dev/stderr

set -e DIR
