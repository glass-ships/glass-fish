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

# set -gx GDK_BACKEND x11,wayland
set -gx XDG_SESSION_TYPE "xcb wayland"
set -gx XDG_CONFIG_HOME $HOME/.config

#----------------------------------------#
# Source secrets as env vars, if present #
#----------------------------------------#

if test -e $DIR/secrets.json || test -L $DIR/secrets.json
    # set secrets (cat .glass-secrets/secrets.json | jq -r 'to_entries[] | "\(.key)=\(.value)"')
    set secrets (cat $DIR/secrets.json)
    for secret in $secrets[2..-2]
        set key (echo $secret | cut -d':' -f1 | tr -d '"' | tr -d ' ')
        set value (echo $secret | cut -d':' -f2- | tr -d '"' | tr -d ' ' | tr -d "," )
        set -gx $key $value
    end
end

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

if test -e ~/.local/bin/micromamba
    set -gx MAMBA_EXE "/home/ge2/.local/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX "/home/ge2/micromamba"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
end

# >>> conda initialize >>>
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniforge3/bin" $PATH
    end
end

if test -f "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
    source "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<


#----------------#
# pyenv settings #
#----------------#
if test -d ~/dev/.pyenv
    fish_add_path -gpP ~/dev/.pyenv/bin
    set -gx PYENV_ROOT ~/dev/.pyenv
    set -gx PATH $PYENV_ROOT/shims $PATH
    pyenv init - | source
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

if test -e $HOME/.config/nvm/nvm.sh
    load_nvm >/dev/stderr
end

set --export BUN_INSTALL "$HOME/.bun"
if test -d $BUN_INSTALL
    set --export PATH $BUN_INSTALL/bin $PATH
end

if test -d ~/.cargo/bin
    fish_add_path -gpP ~/.cargo/bin
end

if type -q direnv
    eval (direnv hook fish)
    # direnv hook fish | source
end

if test -d ~/.pixi/bin
    fish_add_path -gpP ~/.pixi/bin
    pixi completion --shell fish | source
end

if type -q starship
    starship init fish | source
end

# thefuck --alias | source

####################################
set -e DIR
