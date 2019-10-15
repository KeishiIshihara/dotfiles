init_for_ubuntu () {
    sudo apt-get update
    sudo apt update
    ##############################
    ##### Install some tools #####
    ##############################
    sudo apt install -y less net-tools curl git make htop

    ####################################
    ##### Install Shougo/neobundle #####
    ####################################
    sudo apt-get install -y vim
    git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
    # Then, run :NeoBundleInstall on vim to install the other plugins

    ##################################
    ##### Install tmux-powerline #####
    ##################################
    # Install tmux
    sudo apt-get install -y aptitude
    sudo aptitude install -y ruby
    sudo aptitude install -y tmux # NOTE: tmux should be version 1.8. Please check whether you have the right version. If not, downgrade it via apt.

    sudo gem install -y rubygems-update
    sudo update_rubygems
    sudo gem install tmuxinator
    # git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
    git clone git://github.com/erikw/tmux-powerline.git $DOTPATH/.tmux-powerline
    git clone https://github.com/powerline/fonts.git $DOTPATH/fonts
    bash $DOTPATH/fonts/install.sh

    ##################################
    #####     Install pyenv      #####
    ##################################
    sudo apt install -y zlib1g-dev libssl-dev
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    source $DOTPATH/.bashrc


    ##################################
    #####     Install zsh        #####
    ##################################
    sudo apt install -y zsh
    # chsh -s $(which zsh) # change shell bash to zsh # not working

    #########################################################################
    ##### Install Ricty font (http://www.rs.tus.ac.jp/yyusa/ricty.html) #####
    #########################################################################
    # # Install FontForge
    # sudo add-apt-repository ppa:fontforge/fontforge
    # sudo apt-get update
    # sudo apt-get install fontforge

    # # Get Google Fonts Inconsolata and M+ IPA synthesized font Migu 1M
    # mkdir ~/.fonts
    # cp Ricty/Inconsolata/Inconsolata-Bold.ttf ~/.fonts/
    # cp Ricty/Inconsolata/Inconsolata-Regular.ttf ~/.fonts/
    # cp Ricty/migu-1m-20150712/migu-1m-bold.ttf ~/.fonts/
    # cp Ricty/migu-1m-20150712/migu-1m-regular.ttf ~/.fonts/

    # # Run Ricty ge
    # ./Ricty/ricty_generator.sh auto
    # # or ./Ricty/ricty_generator.sh Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf
    # mv Ricty-* ~/.fonts/
    # mv RictyDiscord-* ~/.fonts/

    # # Scan font directories
    # sudo fc-cache -vf
    # fc-list | grep Ri

    # # Set Ricty as default font
    # gconftool-2 --get /apps/gnome-terminal/profiles/Default/font # Show current font
    # echo "->"
    # gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/font "Ricty Regular 12"

    #########################################################################
    ##### Install tex-related software #####
    #########################################################################
    # sudo apt-get install texlive-full
    # sudo apt-get install latexmk

}

init_for_mac () {
    brew update
    ##############################
    ##### Install some tools #####
    ##############################
    brew install less net-tools curl git make htop

    ####################################
    ##### Install Shougo/neobundle #####
    ####################################
    brew install vim
    git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
    # Then, run :NeoBundleInstall on vim to install the other plugins

    ##################################
    ##### Install tmux-powerline #####
    ##################################
    # Install tmux
    # brew install tmux 
    sudo gem install -y tmuxinator
    git clone git://github.com/erikw/tmux-powerline.git $DOTPATH/.tmux-powerline
    git clone https://github.com/powerline/fonts.git
    bash $DOTPATH/fonts/install.sh

    #########################################################################
    ##### Install tex-related software #####
    #########################################################################
    # sudo apt-get install texlive-full
    # sudo apt-get install latexmk
    # brew install texlive-full
    # brew install latexmk

    ##################################
    #####     Install pyenv      #####
    ##################################
    sudo apt update
    sudo apt install -y zlib1g-dev libssl-dev
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    source $DOTPATH/.bashrc

}

if [ "$(uname)" = 'Darwin' ]; then
    echo Hello Mac!
    init_for_mac
else
    echo Hello Ubuntu!
    init_for_ubuntu
fi