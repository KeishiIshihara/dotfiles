This repository has essential dot files in Ubuntu.  
This allow me to apply the same setting to another PC just by running dotfilesLink.sh.  
    
This repositry has been created as follows:  
*************************************  
$ cd  
$ mkdir dotfiles  
$ mv .vimrc dotfiles  
$ mv .gvimrc dotfiles  
$ mv .bashrc dotfiles  
$ mv .bash_profile dotfiles  
$ mv .vim dotfiles  
$ mv .gitconfig dotfiles  
$ mv .gitconfig_global dotfiles  
    
次はシンボリックリンクの作成．  
シンボリックリンクは、違う環境にdotfilesの設定をしたいときにも必要なので、シェルスクリプトで半自動化する．  
dotfilesディレクトリ内にdotfilesLink.shというファイルを作成.  
    
#! /bin/bash  
ln -s ~/dotfiles/.vimrc ~/.vimrc  
ln -s ~/dotfiles/.gvimrc ~/.gvimrc  
ln -s ~/dotfiles/.bashrc ~/.bashrc  
ln -s ~/dotfiles/.bash_profile ~/.bash_profile  
ln -s ~/dotfiles/.vim ~/.vim  
ln -s ~/dotfiles/.gitconfig ~/.gitconfig  
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global  
↑のように書き込んだら、chmodコマンドで実行属性をつけて実行する.  
    
$ chmod +x dotfilesLink.sh  
$ ./dotfilesLink.sh  
*************************************    