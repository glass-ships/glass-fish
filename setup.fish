set DIR (cd (dirname (status -f)); and pwd)
rm -rf ~/.config/fish
ln -s $DIR $HOME/.config/fish
