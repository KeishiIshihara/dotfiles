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
    echo Hello Ubuntu! You are supposed to be Ubuntu
    init_for_ubuntu
fi



# Dotfiles {{{1

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles; export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/b4b4r07/dotfiles.git"; export DOTFILES_GITHUB

# shellcheck disable=SC1078,SC1079,SC2016
dotfiles_logo='
      | |     | |  / _(_) |           
    __| | ___ | |_| |_ _| | ___  ___  
   / _` |/ _ \| __|  _| | |/ _ \/ __| 
  | (_| | (_) | |_| | | | |  __/\__ \ 
   \__,_|\___/ \__|_| |_|_|\___||___/ 
  *** WHAT IS INSIDE? ***
  1. Download https://github.com/b4b4r07/dotfiles.git
  2. Symlinking dot files to your home directory
  3. Execute all sh files within `etc/init/` (optional)
  See the README for documentation.
  https://github.com/b4b4r07/dotfiles
  Copyright (c) 2014 "BABAROT" aka @b4b4r07
  Licensed under the MIT license.
'

dotfiles_download() {
    if [ -d "$DOTPATH" ]; then
        log_fail "$DOTPATH: already exists"
        exit 1
    fi

    e_newline
    e_header "Downloading dotfiles..."

    if is_debug; then
        :
    else
        if is_exists "git"; then
            # --recursive equals to ...
            # git submodule init
            # git submodule update
            git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"

        elif is_exists "curl" || is_exists "wget"; then
            # curl or wget
            local tarball="https://github.com/b4b4r07/dotfiles/archive/master.tar.gz"
            if is_exists "curl"; then
                curl -L "$tarball"

            elif is_exists "wget"; then
                wget -O - "$tarball"

            fi | tar xvz
            if [ ! -d dotfiles-master ]; then
                log_fail "dotfiles-master: not found"
                exit 1
            fi
            command mv -f dotfiles-master "$DOTPATH"

        else
            log_fail "curl or wget required"
            exit 1
        fi
    fi
    e_newline && e_done "Download"
}

dotfiles_deploy() {
    e_newline
    e_header "Deploying dotfiles..."

    if [ ! -d $DOTPATH ]; then
        log_fail "$DOTPATH: not found"
        exit 1
    fi

    cd "$DOTPATH"

    if is_debug; then
        :
    else
        make deploy
    fi &&

        e_newline && e_done "Deploy"
}

dotfiles_initialize() {
    if [ "$1" = "init" ]; then
        e_newline
        e_header "Initializing dotfiles..."

        if is_debug; then
            :
        else
            if [ -f Makefile ]; then
                #DOTPATH="$(dotpath)"
                #export DOTPATH
                #bash "$DOTPATH"/etc/init/init.sh
                make init
            else
                log_fail "Makefile: not found"
                exit 1
            fi
        fi &&

            e_newline && e_done "Initialize"
    fi
}

# A script for the file named "install"
dotfiles_install() {
    # 1. Download the repository
    # ==> downloading
    #
    # Priority: git > curl > wget
    dotfiles_download &&

    # 2. Deploy dotfiles to your home directory
    # ==> deploying
    dotfiles_deploy &&

    # 3. Execute all sh files within etc/init/
    # ==> initializing
    dotfiles_initialize "$@"
}

if echo "$-" | grep -q "i"; then
    # -> source a.sh
    VITALIZED=1
    export VITALIZED

    : return
else
    # three patterns
    # -> cat a.sh | bash
    # -> bash -c "$(cat a.sh)"
    # -> bash a.sh

    # -> bash a.sh
    if [ "$0" = "${BASH_SOURCE:-}" ]; then
        exit
    fi

    # -> cat a.sh | bash
    # -> bash -c "$(cat a.sh)"
    if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then
        # if already vitalized, skip to run dotfiles_install
        if [ "${VITALIZED:=0}" = 1 ]; then
            exit
        fi

        trap "e_error 'terminated'; exit 1" INT ERR
        echo "$dotfiles_logo"
        dotfiles_install "$@"

        # Restart shell if specified "bash -c $(curl -L {URL})"
        # not restart:
        #   curl -L {URL} | bash
        if [ -p /dev/stdin ]; then
            e_warning "Now continue with Rebooting your shell"
        else
            e_newline
            e_arrow "Restarting your shell..."
            exec "${SHELL:-/bin/zsh}"
        fi
    fi
fi

# __END__ {{{1
# vim:fdm=marker