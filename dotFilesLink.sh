#! /bin/bash

######Create symlinks####################################
ln -s ~/dotfiles/.vimrc ~/.vimrc
#ln -s ~/dotfiles/.gvimrc ~/.gvimrc
#ln -s ~/dotfiles/.bashrc ~/.bashrc
#ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.vim ~/.vim
#ln -s ~/dotfiles/.gitconfig ~/.gitconfig
#ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
#ln -s ~/dotfiles/.ros_setup ~/.ros_setup
ln -s ~/dotfiles/.ycm_extra_conf.py ~/catkin_ws/.ycm_extra_conf.py
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux-powerlinerc ~/.tmux-powerlinerc
ln -s ~/dotfiles/.tmuxinator ~/.tmuxinator
ln -s ~/dotfiles/.tmuxautorun ~/.tmuxautorun
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc



######Install Shougo/neobundle####################################
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim



######Install tmux-powerline####################################
# Install tmux
sudo apt-get install aptitude
sudo aptitude install tmux

# Original repository:git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
git clone git://github.com/shuj1/tmux-powerline.git ~/tmux-powerline

# Copy the symbol font to a valid font path.
mkdir ~/.fonts
cp ~/tmux-powerline/fonts/PowerlineSymbols.otf ~/.fonts/

# Update font cache for the path the font was moved to (root priveleges may be needed to update cache for the system-wide paths).
fc-cache -vf ~/.fonts/

# Install the fontconfig file. For newer versions of fontconfig the config path is ~/.config/fontconfig/conf.d/, for older versions it’s ~/.fonts.conf.d/ .
mkdir -p ~/.config/fontconfig/conf.d
cp ~/tmux-powerline/fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/


##### Install Ricty font (http://www.rs.tus.ac.jp/yyusa/ricty.html)#####
## Install FontForge
sudo add-apt-repository ppa:fontforge/fontforge
sudo apt-get update
sudo apt-get install fontforge

## Get Google Fonts Inconsolata and M+ IPA synthesized font Migu 1M
cp Ricty/Inconsolata/Inconsolata-Bold.ttf ~/.fonts/
cp Ricty/Inconsolata/Inconsolata-Regular.ttf ~/.fonts/
cp Ricty/migu-1m-20150712/migu-1m-bold.ttf ~/.fonts/
cp Ricty/migu-1m-20150712/migu-1m-regular.ttf ~/.fonts/

## Run Ricty ge
./Ricty/ricty_generator.sh auto
# or ./Ricty/ricty_generator.sh Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf
mv Ricty-* ~/.fonts/
mv RictyDiscord-* ~/.fonts/

## Scan font directories
sudo fc-cache -vf
fc-list | grep Ri

## Set Ricty as default font
gconftool-2 --get /apps/gnome-terminal/profiles/Default/font # Show current font
echo "->"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/font "Ricty Regular 12"


###### Install Qt creator (ros_rqt_plugin) ###################################
###### https://github.com/ros-industrial/ros_qtc_plugin/wiki/1.-How-to-Install-(Users)
# Installation for Ubuntu 14.04
sudo add-apt-repository ppa:levi-armstrong/qt-libraries-trusty
sudo add-apt-repository ppa:levi-armstrong/ppa
sudo apt-get update && sudo apt-get install qt57creator-plugin-ros

# May need to remove old PPA
sudo add-apt-repository --remove ppa:beineri/opt-qt57-trusty
sudo add-apt-repository --remove ppa:beineri/opt-qt571-trusty

# Create a symbolic link file
sudo ln -s /opt/qt57/bin/qtcreator-wrapper /usr/local/bin/qtcreator

