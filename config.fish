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

# Reset PATH based on system default (/etc/environment)
set -gx PATH $HOME/.local/bin (string split ":" (cat /etc/environment | grep -oP '(?<=PATH=")[^"]*'))

# Source secrets as env vars, if present
if test -e $DIR/secrets.fish
    source $DIR/secrets.fish
end


# Python/Poetry settings
set -gx PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring
set -gx POETRY_HOME /opt/poetry
fish_add_path -gpP /opt/poetry/bin
if type -q poetry
    poetry config virtualenvs.in-project true
end
set -u VIRTUAL_ENV
set -u VIRTUAL_ENV_PROMPT

# pyenv settings
if test -d ~/dev/.pyenv
    fish_add_path -gpP ~/dev/.pyenv/bin
    set -gx PYENV_ROOT ~/dev/.pyenv
    set -gx PATH $PYENV_ROOT/shims $PATH
    pyenv init - | source
end

### Enable rust, if present
if test -d ~/.cargo/bin
    fish_add_path -gpP ~/.cargo/bin
end

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
            echo "importing $file"
            source $file
    end
end

####################################
### Additional Configs and Paths ###
####################################

# Call load_nvm to listen on directory change
if test -e $HOME/.nvm/nvm.sh
    load_nvm >/dev/stderr
else
    echo "nvm not found" >/dev/stderr
end

# configure thefuck 
# thefuck --alias | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

####################################
set -e DIR
