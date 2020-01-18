#!/bin/bash
#-----------------------------
#
#    Initialize Environment
#
#-----------------------------

# TODO;
# - [ ] Revise init_for_ubuntu
# - [ ] Revise init_for_mac


is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

ostype() {
    # shellcheck disable=SC2119
    uname | lower
}

os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='osx'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

user_detect() {
    if [ "$(whoami)" = 'ishiharakeishi' ]; then
        # export PLATFORM
        CURRENT_USER='ishihara-mac'
    elif [ "$(whoami)" = 'keishish' ]; then
        CURRENT_USER='dluef-kde'
    elif [ "$(whoami)" = 'aisl' ]; then
        CURRENT_USER='aisl-pc'
    else
        CURRENT_USER='unknown'
    fi
}

e_newline() {
    printf "\n" 
}

e_header() {
    printf " \033[37;1m%s\033[m\n" "$*" 
}

e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2 
}

e_warning() {
    printf " \033[31m%s\033[m\n" "$*" 
}

e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*" 
}

e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*" 
}

e_success() {
    printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"
}

set_dotpath() {
    if [ -z "${DOTPATH:-}" ]; then
        DOTPATH=$HOME/dotfiles; export DOTPATH
        echo " DOTPATH is set as $HOME/dotfiles"
    else
        echo " DOTPATH already exists."
    fi
}


init_for_ubuntu () {
    set_dotpath

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

init_for_macOS () {
    ## make sure that dotpath exits
    set_dotpath

    ##############################
    ##### Install Homebrew   #####
    ##############################
    e_newline
    e_header "Installing homebrew..."

    if ! is_exists "brew" ; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'brew already exists.'
    fi

    brew update

    ##############################
    ##### Install packages   #####
    ##############################
    e_newline
    e_header "Installing packages..."

    brew install less 
    brew install curl 
    brew install htop 
    brew install wget 
    brew install reattach-to-user-namespace 
    brew install tmux 
    brew install vim
    # brew install texlive-full
    # brew install latexmk

    ####################################
    ##### Install Shougo/neobundle #####
    ####################################
    # git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
    # Then, run :NeoBundleInstall on vim to install the other plugins

    ##################################
    ##### Install tmux-powerline #####
    ##################################
    gem install tmuxinator
    if [ ! -d "$DOTPATH/.tmux-powerline" ]; then
        git clone git://github.com/erikw/tmux-powerline.git $DOTPATH/.tmux-powerline
    else
        echo ' ~/.tmux-powerline already exists.'
    fi

    if [ ! -d "$DOTPATH/fonts" ]; then
        git clone https://github.com/powerline/fonts.git $DOTPATH/
    else
        echo ' ~/fonts already exists.'
    fi

    bash $DOTPATH/fonts/install.sh

    #########################################################################
    ##### Install tex-related software #####
    #########################################################################

    ##################################
    #####     Install pyenv      #####
    ##################################
    
    e_newline && e_done "Initialize"
}


os_detect
user_detect

# e_warning '[WARNING] test'
# e_header '[HEADER] test'
# e_error '[ERROR] test'
# e_done '[DONE] test'
# e_arrow '[ARROW] test'
# e_success '[ARROW] test'
# exit 0


## Following are my personal used PCs
if [ "$PLATFORM" = 'osx' ] && [ "$CURRENT_USER" = 'ishihara-mac' ]; then
    echo 'Initializing for ishihara macOS..'
    init_for_macOS
    IS_DONE=1

elif [ "$PLATFORM" = 'linux' ] && [ "$CURRENT_USER" = 'dluef-kde' ]; then
    echo 'Initializing for KDE 17. ..user edition..'
    init_for_ubuntu
    IS_DONE=1

elif [ "$PLATFORM" = 'linux' ] && [ "$CURRENT_USER" = 'aisl-pc' ]; then
    echo 'Initializing for Ubuntu 18.04 in aisl..'
    init_for_ubuntu
    IS_DONE=1

else
    e_warning '[WARNING] This platform is not familiar.'
fi


## This is for new env
if [ ! "${IS_DONE:=0}" = 1 ]; then
    e_newline
    e_header 'Welcome to new PC!'

    if [ "$PLATFORM" = 'osx' ]; then
        echo 'Initializing for macOS..'
        init_for_macOS

    elif [ "$PLATFORM" = 'linux' ]; then
        echo 'Initializing for linux ..'
        init_for_ubuntu

    else
        e_error '[ERROR] This platform is not supported.'
    fi
fi
