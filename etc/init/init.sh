#!/bin/bash
#===============================
#
#    Initialize Environment
#
#===============================

# TODO;
# - [ ] Revise init_for_ubuntu
# - [ ] Revise init_for_mac


######  UTILS  ######

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

e_newline() { printf "\n"; }

e_header() { printf " \033[37;1m%s\033[m\n" "$*"; }

e_error() { printf " \033[31m%s\033[m\n" "✖ $*" 1>&2; }

e_warning() { printf " \033[31m%s\033[m\n" "$*"; }

e_done() { printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"; }

e_arrow() { printf " \033[37;1m%s\033[m\n" "➜ $*"; }

e_success() { printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"; }

set_dotpath() {
    if [ -z "${DOTPATH:-}" ]; then
        DOTPATH=$HOME/dotfiles; export DOTPATH
        echo "  DOTPATH is set as $DOTPATH"
    else
        echo "  DOTPATH=$DOTPATH: already exists."
    fi
}


######  INITIALIZE FUNCTIONS  #####

init_for_ubuntu () {
    ## make sure that dotpath exits
    set_dotpath

    sudo apt-get update
    sudo apt update

    ##################################
    ##### Install some  packages #####
    ##################################
    e_newline
    e_header "Installing packages..."

    sudo apt install -y gcc make less net-tools curl wget git htop
    sudo apt install -y build-essentials # c++ compiler
    sudo apt install -y libffi-dev
    sudo apt install -y libssl-dev # openssl
    sudo apt install -y zlib1g-dev
    sudo apt install -y liblzma-dev
    sudo apt install -y libbz2-dev # bz2
    sudo apt install -y libreadline-dev # readline
    sudo apt install -y libsqlite3-dev # sqlite3
    sudo apt install -y xclip # for tmux
    sudo apt install -y libncurses5-dev libgdbm-dev  tcl-dev tk-dev

    ####################################
    ##### Install Shougo/neobundle #####
    ####################################
    sudo apt install -y vim
    git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
    # Then, run :NeoBundleInstall on vim to install the other plugins

    ##################################
    ##### Install tmux-powerline #####
    ##################################
    # Install tmux
    # sudo apt install -y aptitude
    # sudo aptitude install -y ruby
    # sudo aptitude install -y tmux # NOTE: tmux should be version 1.8. Please check whether you have the right version. If not, downgrade it via apt.

    # sudo gem install rubygems-update
    # sudo update_rubygems
    # sudo gem install tmuxinator
    sudo apt install -y tmux
    sudo apt install -y tmuxinator

    git clone https://github.com/powerline/fonts.git $DOTPATH/fonts
    bash $DOTPATH/fonts/install.sh

    ##################################
    #####     Install pyenv      #####
    ##################################
    # pyenv
    if [ ! -d "$HOME/.pyenv" ]; then
         git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    fi
    # pyenv-virtualenv
    if [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ]; then
        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    fi

    ##################################
    #####     Install zsh        #####
    ##################################
    sudo apt install -y zsh
    if [ ! "$(cat /etc/shells | grep '/usr/bin/zsh')" ]; then
        eval echo "You have to edit /etc/shells by adding $(which zsh)"
        eval echo "Then, just do: chsh -s $(which zsh)"
    fi
    # if [ ! "$(echo $SHELL | grep 'zsh')" ]; then
    #     chsh -s $(which zsh) # change shell bash to zsh # not working
    # fi

    sudo apt install -y peco
    # sudo apt install -y fzf

    #########################################################################
    ##### Install tex-related software #####
    #########################################################################
    # sudo apt install texlive-full
    # sudo apt install latexmk

   # finish
    e_newline && e_success "packages are installed."

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
    brew install zsh
    brew install reattach-to-user-namespace
    brew install tmux
    brew install vim
    brew install peco
    brew install fzf
    # brew install texlive-full
    # brew install latexmk
    brew install pyenv


    ####################################
    ##### Install Shougo/neobundle #####
    ####################################
    git clone https://github.com/Shougo/neobundle.vim $DOTPATH/.vim/bundle/neobundle.vim
    # Then, run :NeoBundleInstall on vim to install the other plugins

    ##################################
    ##### Install tmux-powerline #####
    ##################################
    gem install tmuxinator

    ## .tmux-powerline is now customized and is maintained as a part of this dotfiles repository
    ## so no need to install from git clone, but only fonts
    if [ ! -d "$DOTPATH/fonts" ]; then
        git clone https://github.com/powerline/fonts.git $DOTPATH/fonts
    else
        echo ' ~/fonts already exists.'
    fi
    bash $DOTPATH/fonts/install.sh


    # finish
    e_newline && e_success "packages are installed."
}


### echo wrappers usage ###
#   e_newline
#   e_warning '[WARNING] test'
#   e_header  '[HEADER] test'
#   e_error   '[ERROR] test'
#   e_done    '[DONE] test'
#   e_arrow   '[ARROW] test'
#   e_success '[ARROW] test'
#  exit 0

os_detect
user_detect

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
