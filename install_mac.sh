#!/bin/bash

#rm -rf ~/.vimrc
#rm -rf ~/.ycm_extra_conf.py

cp -n .vimrc ~
cp -n .ycm_extra_conf.py ~

mkdir ~/.vim
rm -rf ~/.vim/plugin
rm -rf ~/.vim/colors
cp -R ./plugin ~/.vim
cp -R ./colors ~/.vim

mkdir ~/.fonts
rm -rf ~/.fonts/PowerlineSymbols.otf
rm -rf ~/.fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf
cp ./fonts/PowerlineSymbols.otf ~/.fonts
cp ./fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf ~/.fonts
fc-cache -vf ~/.fonts

brew install vim
brew install go
brew install clang
brew install nodejs
brew install npm
brew install mono

mkdir -p ~/.config/fontconfig/conf.d
rm -rf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
cp ./fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -c "PluginInstall" -c "q" -c "q"

cd ~/.vim/bundle/YouCompleteMe
./install.py --all

echo "Done!"

