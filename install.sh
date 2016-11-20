#!/bin/bash

if which apt-get > /dev/null
then
    apt-get install -y ctags build-essential cmake python-dev python3-dev fontconfig git
    var=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    systemVersion='DISTRIB_RELEASE=16.04'
    if [ $var == $systemVersion ]
    then
        apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
            libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev
        apt-get remove -y vim vim-runtime gvim
        apt-get remove -y vim-tiny vim-common vim-gui-common

        rm -rf ~/vim
        rm -rf /usr/share/vim/vim74
        git clone https://github.com/vim/vim.git ~/vim
        cd ~/vim
        ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
        make VIMRUNTIMEDIR=/usr/share/vim/vim74
        make install
        cd -
    else
        apt-get install -y vim
    fi
elif which yum > /dev/null
then
    yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel git
fi

#rm -rf ~/.vimrc
#rm -rf ~/.ycm_extra_conf.py

cp -u .vimrc ~
cp -u .ycm_extra_conf.py ~

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

jumbo install vim
jumbo install go
jumbo install clang
jumbo install nodejs
jumbo install llvm

mkdir -p ~/.config/fontconfig/conf.d
rm -rf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
cp ./fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -c "PluginInstall" -c "q" -c "q"

cd ~/.vim/bundle/YouCompleteMe
export LD_LIBRARY_PATH=~/.jumbo/lib/llvm/:~/.jumbo/lib/:~.jumbo/opt/gcc5/lib64/:$LD_LIBRARY_PATH
export PATH=~/.jumbo/opt/gcc5/bin:$PATH
./install.py --clang-completer
./install.py --gocode-completer
./install.py --tern-completer

echo "Done!"

