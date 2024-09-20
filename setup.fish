"""
 ________ .__                              _________.__     .__                
 /  _____/ |  |  _____     ______  ______  /   _____/|  |__  |__|______   ______
/   \  ___ |  |  \__  \   /  ___/ /  ___/  \_____  \ |  |  \ |  |\____ \ /  ___/
\    \_\  \|  |__ / __ \_ \___ \  \___ \   /        \|   Y  \|  ||  |_> >\___ \ 
 \______  /|____/(____  //____  >/____  > /_______  /|___|  /|__||   __//____  >
        \/            \/      \/      \/          \/      \/     |__|        \/ 
"""

set DIR (cd (dirname (status -f)); and pwd)

## "install" glass-fish
echo -e '\nInstalling glass-fish...\n'
rm -rf ~/.config/fish
ln -s $DIR $HOME/.config/fish

## Generate SSH key if it doesn't exist
echo -e '\nChecking for SSH key...\n'
if not test -e ~/.ssh/id_rsa
	echo -e '\nCreating SSH key...\n'
        ssh-keygen -t rsa
        #cp ssh-config ~/.ssh/config
else
        echo -e '\n\e[95mNOTICE\e[0m: SSH key already exists.'
end

## VIM settings
# echo -e '\nCopying VIM settings...\n'
# cp .vimrc $HOME/.vimrc


####################
### Git settings ###
####################

## set git user info
# echo -e '\nSetting Git user info...\n' 
# read -l -P 'Please enter your Git username: ' gituser
# read -l -P 'Please enter your Git email: ' gitemail
# git config --global user.name "$gituser"
# git config --global user.email "$gitemail"

## set global gitignore
# rm -f ~/.gitignore
# ln -s $DIR/gitignore ~/.gitignore
# git config --global core.excludesfile '~/.gitignore'

## set default name for new git repos
# git config --global init.defaultBranch main

############################################
echo -e '\nglass-fish setup is complete!\n' 
