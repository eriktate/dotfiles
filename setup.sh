cd $HOME

# shell links
sudo ln -s $HOME/dotfiles/.bashrc .bashrc
sudo ln -s $HOME/dotfiles/.inputrc .inputrc

# alacritty links
sudo ln -s $HOME/dotfiles/.alacritty.yml .alacritty.yml
sudo ln -s $HOME/dotfiles/.gruvbox.yml .gruvbox.yml

# tmux
sudo ln -s $HOME/dotfiles/.tmux.conf .tmux.conf

# vim
pushd $HOME/.config
sudo ln -s $HOME/dotfiles/nvim nvim
popd
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
