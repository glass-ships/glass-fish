echo """
 ________ .__                              _________.__     .__                
 /  _____/ |  |  _____     ______  ______  /   _____/|  |__  |__|______   ______
/   \  ___ |  |  \__  \   /  ___/ /  ___/  \_____  \ |  |  \ |  |\____ \ /  ___/
\    \_\  \|  |__ / __ \_ \___ \  \___ \   /        \|   Y  \|  ||  |_> >\___ \ 
 \______  /|____/(____  //____  >/____  > /_______  /|___|  /|__||   __//____  >
        \/            \/      \/      \/          \/      \/     |__|        \/ 
"""

set DIR (cd (dirname (status -f)); and pwd)

## "install" glass-fish
echo -e '\nInstalling glass-fish...'
rm -rf ~/.config/fish
ln -s $DIR $HOME/.config/fish

## Generate SSH key if it doesn't exist
echo -e '\nChecking for SSH key...'
if not test -e ~/.ssh/id_rsa
	echo -e '\nCreating SSH key...'
        ssh-keygen -t rsa
else
        echo -e '\n\e[95mNOTICE\e[0m: SSH key already exists.'
end

####################
### Git settings ###
####################

## set git user info, if not already set
echo -e '\nSetting Git user info...' 

if not test -n (git config --global user.name)
        set -l gituser (read -l -P 'Please enter your Git username: ')
        git config --global user.name $gituser
else
        echo -e '\n\e[95mNOTICE\e[0m: Git user name already set.'
end

if not test -n (git config --global user.email)
        set -l gitemail (read -l -P 'Please enter your Git email: ')
        git config --global user.email $gitemail
else
        echo -e '\n\e[95mNOTICE\e[0m: Git email already set.'
end

# read -l -P 'Please enter your Git username: ' gituser
# read -l -P 'Please enter your Git email: ' gitemail
# git config --global user.name "$gituser"
# git config --global user.email "$gitemail"

############################################
echo -e '\nglass-fish setup is complete!' 
