#/bin/bash

#======================
#  .bashrc
#
#  (c) keishihara
#======================

os_detect() {
    export PLATFORM
    case "$(uname)" in
        'Darwin')   PLATFORM='osx'     ;;
        'Linux')    PLATFORM='linux'   ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# path to dotfiles directory
# export DOTPATH=$(git rev-parse --show-toplevel)
export DOTPATH=$HOME'/dotfiles'


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## aliases
# enable color support of ls
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
fi

alias so='source'
alias sb='source ~/.bashrc'
alias v='vim'
alias vi='vim'
alias vb='vim ~/.bashrc'
# alias c='cdr'
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias back='pushd'
# alias diff='diff -U1'

# some more ls aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias l='ls -1F'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lll='ls -a1'
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls

alias tm='tmux'
alias t='tmux ls'
alias tl='tmux ls'
alias ta='tmux a'
alias tksv='tmux kill-sever'
alias tkss='tmux kill-session -t'
alias tk='tmux list-keys'

if type "nvidia-smi" >/dev/null 2>&1; then
    alias smi='nvidia-smi -l 1'
fi

alias cdo="cd $DOTPATH && git status"

cdls ()
{
    \cd "$@" && ll -h
}
alias cd="cdls"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

ulimit -c unlimited

# -------- Source other configs -----------
# tmux
# PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# source ~/.tmuxinator/tmuxinator.bash
# source ~/.tmuxautorun
# source ~/.aisl_ssh_list # aisl ip address
# source ~/.ros_setup


if [ "$(uname)" = 'Darwin' ]; then
    echo Hello Mac!

    # ------- pyenv config ----------
    # pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
    export PYENV_ROOT=/usr/local/var/pyenv
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then # pyenvさんに自動補完機能を提供してもらう
        eval "$(pyenv init -)"
    fi
    # eval "$(pyenv virtualenv-init -)"
    # export PATH="$HOME/.pyenv/shims:$PATH"

elif [ "$(whoami)" = 'aisl' ]; then
    # --------- only aisl pc  -----------
    echo Hello Ubuntu! on aisl

    [ -r /home/aisl/.byobu/prompt ] && . /home/aisl/.byobu/prompt #byobu-prompt#
    # ------ CUDA ----------
    export PATH="/usr/local/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

    # ------- ROS ----------
    # It's convenient if the ROS environment variables are automatically added 
    # to your bash session every time a new shell is launched. (only if using Linux)
    source /opt/ros/melodic/setup.bash
    source ~/catkin_ws/devel/setup.bash
    export CARLA_ROS_BRIDGE=/home/aisl/carla_0.8.4/carla/carla_ros_bridge

    # Set default Docker runtime to use in '~/HSR/docker/docker-compose.yml':
    # 'runc' (Docker default) or 'nvidia' (Nvidia Docker 2).
    export DOCKER_RUNTIME=nvidia

    # ------- pyenv config ----------
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init - zsh --no-rehash)"
        eval "$(pyenv virtualenv-init -)"
    fi
    # export PATH="$HOME/.pyenv/shims:$PATH"

elif [ "$(whoami)" = "keishish" ]; then
    # --------- only the pc @ uef machine learning lab  -----------
    # --------- cuda 10.0 (only pc@uef) -----------
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64"

    # ------- ROS ----------
    source /opt/ros/melodic/setup.bash
    source ~/catkin_ws/devel/setup.bash

    # ------- pyenv config ----------
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init - zsh --no-rehash)"
        eval "$(pyenv virtualenv-init -)"
    fi
    # export PATH="$HOME/.pyenv/shims:$PATH"

    # -------- Conda ---------
    # see .zshrc

else
    echo "Unmet OS before!!"
    # detect os
    if [ -z "${PLATFORM:=''}" ]; then os_detect; fi

    if [ "${PLATFORM:='unknown'}" = 'osx' ]; then
        echo "Hello macOS!"
        # ------- pyenv config ----------
        # pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
        export PYENV_ROOT=/usr/local/var/pyenv
        export PATH="$PYENV_ROOT/bin:$PATH"
        if command -v pyenv 1>/dev/null 2>&1; then # pyenvさんに自動補完機能を提供してもらう
            eval "$(pyenv init -)"
        fi
        # eval "$(pyenv virtualenv-init -)"
        # export PATH="$HOME/.pyenv/shims:$PATH"

    elif [ "${PLATFORM:='unknown'}" = 'linux' ]; then
        # ------ CUDA ----------

        # ------- ROS ----------

        # ------- pyenv config ----------
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        if command -v pyenv 1>/dev/null 2>&1; then
            eval "$(pyenv init -)"
        fi
        # eval "$(pyenv virtualenv-init -)"
        # export PATH="$HOME/.pyenv/shims:$PATH"
    fi
fi


## TIPS
# alias, source, and shell variable should be written this file (.bashrc or .zshrc)
# env variable (export) should be written in .bash_profile or .zprofile or .zshenv

# Cleanup enery single Env Variables
eval $DOTPATH/bin/backupenv         # make backup of current env
source $DOTPATH/bin/cleanup_envar   # cleanup messsy env variables

# Finish sourcing .bashrc
echo '.bashrc: Sucessfully sourced;)'

# Launch and attach to tmux server
source ~/.tmux/tmuxautorun