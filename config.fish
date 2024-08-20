#!/usr/bin/env fish
set DIR (dirname (status --current-filename))

#####################
###  Options etc. ###
#####################

set -e OLDPWD

# Force cmdline password entry for ssh and git 
set -e SSH_ASKPASS
set -e GIT_ASKPASS

umask 022

#########################
### Environment Setup ###
#########################

# Reset PATH based on system default (/etc/environment)
set -gx PATH $HOME/.local/bin (string split ":" (cat /etc/environment | grep -oP '(?<=PATH=")[^"]*'))

set -gx GDK_BACKEND wayland,x11
set -gx XDG_CONFIG_HOME $HOME/.config

# Source secrets as env vars, if present
if test -e $DIR/secrets.fish || test -L $DIR/secrets.fish
    source $DIR/secrets.fish
end

#-----------------------------------#
# Conda / Mamba checks and settings #
#-----------------------------------#

# ...

#------------------------#
# Python/Poetry settings #
#------------------------#
set -gx PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring
set -gx POETRY_HOME /opt/poetry
if test -d /opt/poetry/bin
    fish_add_path -gpP /opt/poetry/bin
poetry config virtualenvs.in-project true
end
set -u VIRTUAL_ENV
set -u VIRTUAL_ENV_PROMPT

#----------------#
# pyenv settings #
#----------------#
if test -d ~/dev/.pyenv
    fish_add_path -gpP ~/dev/.pyenv/bin
    set -gx PYENV_ROOT ~/dev/.pyenv
    set -gx PATH $PYENV_ROOT/shims $PATH
    pyenv init - | source
end

#--------------------------#
#  Enable rust, if present #
#--------------------------#
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
            # echo "importing $file" >/dev/stderr
            source $file
    end
end

####################################
### Additional Configs and Paths ###
####################################

if test -e $HOME/.nvm/nvm.sh
    # load_nvm >/dev/stderr
    echo "nvm found"
else
    echo "nvm not found" >/dev/stderr
end


if type -q direnv
    eval (direnv hook fish)
    # direnv hook fish | source
end

# configure thefuck 
# thefuck --alias | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

####################################
set -e DIR


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<

