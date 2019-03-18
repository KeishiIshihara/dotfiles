## Tested in the docker image of ubuntu:latest

## DockerならDockerfileに書けば良いが，ダウンロードしてきたイメージを元に
## コンテナを起動した時などに使えるかも．

apt-get update
apt update
##############################
##### Install some tools #####
##############################
apt install -y less net-tools curl vim git make git

####################################
##### Install Shougo/neobundle #####
####################################
apt-get isntall -y vim
# git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
# Then, run :NeoBundleInstall on vim to install the other plugins



##################################
##### Install tmux-powerline #####
##################################
# Install tmux
apt-get install aptitude
aptitude install ruby
aptitude install tmux # NOTE: tmux should be version 1.8. Please check whether you have the right version. If not, downgrade it via apt.

gem install rubygems-update
update_rubygems
gem install tmuxinator
# git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
