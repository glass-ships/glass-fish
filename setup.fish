set DIR (cd (dirname (status -f)); and pwd)

# "install" glass-fish
rm -rf ~/.config/fish
ln -s $DIR $HOME/.config/fish

# set git to globally ignore ipynb_checkpoints
git config --global core.excludesfile '~/.gitignore'
echo '.ipynb_checkpoints' >> ~/.gitignore
echo '*/.ipynb_checkpoints' >> ~/.gitignore
