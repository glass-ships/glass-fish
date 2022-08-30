set DIR (cd (dirname (status -f)); and pwd)

# "install" glass-fish
echo -e '\nInstalling glass-fish...\n'
rm -rf ~/.config/fish
ln -s $DIR $HOME/.config/fish

# VIM settings
echo -e '\nCopying VIM settings...\n'
cp vimrc $HOME/.vimrc

echo -e '\nChecking for SSH key...\n'
if not test -e ~/.ssh/id_rsa
	echo -e '\nCreating SSH key...\n'
        ssh-keygen -t rsa
        #cp ssh-config ~/.ssh/config
else
        echo -e '\n\e[95mNOTICE\e[0m: SSH key already exists.'
end

# set git user info
echo -e '\nSetting Git user info...\n' 
read -l -P 'Please enter your Git username: ' gituser
read -l -P 'Please enter your Git email: ' gitemail
git config --global user.name "$gituser"
git config --global user.email "$gitemail"
git config --global init.defaultBranch main # set default branch to "main" instead of "master"

# set git to globally ignore ipynb_checkpoints
echo -e '\nSetting Git default ignores...\n'
git config --global core.excludesfile '~/.gitignore'
echo -e '.ipynb_checkpoints' >> ~/.gitignore
echo -e '*/.ipynb_checkpoints' >> ~/.gitignore

# set default name for new git repos
git config --global init.defaultBranch main


echo -e '\nglass-fish setup is complete!\n' 
