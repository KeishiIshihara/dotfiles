## Tested in the docker image of ubuntu:latest

## DockerならDockerfileに書けば良いが，ダウンロードしてきたイメージを元に
## コンテナを起動した時などに使えるかも．

apt-get update
apt update
##############################
##### Install some tools #####
##############################
apt install -y less net-tools curl git make

####################################
##### Install Shougo/neobundle #####
####################################
apt-get isntall -y vim
git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
# git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
# Then, run :NeoBundleInstall on vim to install the other plugins



##################################
##### Install tmux-powerline #####
##################################
# Install tmux
apt-get install -y aptitude
aptitude install -y ruby
aptitude install -y tmux # NOTE: tmux should be version 1.8. Please check whether you have the right version. If not, downgrade it via apt.

gem install -y rubygems-update
update_rubygems
gem install -y tmuxinator
# git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline

# Install tmux
sudo apt-get install -y aptitude
sudo aptitude install -y ruby
sudo aptitude install -y tmux # NOTE: tmux should be version 1.8. Please check whether you have the right version. If not, downgrade it via apt.

# git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
git clone git://github.com/erikw/tmux-powerline.git $DOTPATH/.tmux-powerline
git clone https://github.com/powerline/fonts.git
bash $DOTPATH/fonts/install.sh