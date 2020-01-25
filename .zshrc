#!/usr/local/bin/zsh

#======================
#  .zshrc
#
#  (c) keishihara
#======================


## UTILs here

e_header() { printf " \033[37;1m%s\033[m\n" "$*"; }

ostype() {
    echo ${(L):-$(uname)}
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

function command_not_found_handler() {
    echo -e '\e[31m
    ooooo      ooo               .    .o88o.                                         .o8
    `888b.     `8`             .o8    888 `"                                        "888
     8 `88b.    8   .ooooo.  .o888oo o888oo   .ooooo.  oooo  oooo  ooo. .oo.    .oooo888
     8   `88b.  8  d88` `88b   888    888    d88` `88b `888  `888  `888P"Y88b  d88` `888
     8     `88b.8  888   888   888    888    888   888  888   888   888   888  888   888
     8       `888  888   888   888 .  888    888   888  888   888   888   888  888   888
    o8o        `8  `Y8bod8P`   "888" o888o   `Y8bod8P`  `V88V"V8P` o888o o888o `Y8bod88P"
    '
}


## .zshrc starts here

# ---- basic configs ------
# source ~/.bashrc

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# dotfileのパス
export DOTPATH=$HOME'/dotfiles'
export PATH="$DOTPATH/bin:$PATH"

# 色を使用
autoload -Uz colors
colors

# 補完
# autoload -Uz compinit
autoload -U compinit
compinit

# emacsキーバインド
bindkey -e  ## currently disalbed

# 他のターミナルとヒストリーを共有
# setopt share_history ## currently disalbed

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# どこからでも参照できるディレクトリパス
# cdpath=(~)  ## currently disalbed

# コマンドミスを修正
# setopt correct  ## currently disalbed

# backspace,deleteキーを使えるように
stty erase "^?"
bindkey "^[[3~" delete-char


# ------ alias  ---------
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

alias dirs='dirs -v' # with line numbers
alias so='source'
alias sz='source ~/.zshrc'
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p' # able to make multiple dirs
alias back='pushd'

alias ..='cd ..'
alias ...='cd ../..'
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias l='ls -1F'           # Show long file information
alias lll='ls -a1'
alias la='ls -AF'          # Show hidden files
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
alias tkv='tmux kill-server'
alias tks='tmux kill-session -t'
alias tk='tmux list-keys'

alias smi='nvidia-smi -l 1'

alias cdo="cd $DOTPATH"

# ---- frequentry commands' setting -----


# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

# ------ Others -------
# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# enable color support of ls
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
    # cdの後にlsを実行
    chpwd() { ls -FG }
elif [ "$(uname)" = 'Linux' ]; then
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
    # cdの後にlsを実行
    chpwd() { ls -F --color=auto }
fi

if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# -------- completion & history ----------
# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# 複数ファイルのmv 例　zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'


# ------- prompt ---------
# prompt
PROMPT='%F{red}[${reset_color}%n%F{red}]%#%F{reset_color} '
RPROMPT='at %F{blue}[%~]'

# git設定をプロンプトに追加
autoload -Uz vcs_info #Version Control System (VCS)
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


# -------- Source other configs -----------
# tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/.tmuxinator/tmuxinator.zsh
# aisl ip address
if [ -f "$HOME/.aisl_ssh_list" ]; then source ~/.aisl_ssh_list; fi


if [ "$(uname)" = 'Darwin' ]; then
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

elif [ "$(whoami)" = 'aisl' ]; then
    # --------- only aisl pc  -----------
    echo "Hello Ubuntu! on aisl"

    [ -r /home/aisl/.byobu/prompt ] && . /home/aisl/.byobu/prompt #byobu-prompt#

    # ------ CUDA ----------
    export PATH="/usr/local/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

    # ------- ROS ----------
    # It's convenient if the ROS environment variables are automatically added
    # to your bash session every time a new shell is launched. (only if using Linux)
    source /opt/ros/melodic/setup.zsh
    source ~/catkin_ws/develtup.zsh
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
    e_header "Hello Ubuntu! (KDE neon 5.17)"

    # --------- cuda 10.0 (only pc@uef) -----------
    # export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64"
    export PATH="/usr/local/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

    # ------- ROS ----------
    # It's convenient if the ROS environment variables are automatically added
    # to your bash session every time a new shell is launched. (only if using Linux)
    source /opt/ros/melodic/setup.zsh
    source ~/catkin_ws/devel/setup.zsh

    # ------ Carla Client ------
    export PYTHONPATH="$PYTHONPATH:/home/keishish/ishihara/carla-0.8.4/PythonClient/carla"

    # ------- pyenv config ----------
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init - zsh --no-rehash)"
        eval "$(pyenv virtualenv-init -)"
    fi
    # export PATH="$HOME/.pyenv/shims:$PATH"

    # -------- Conda ---------
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/keishish/.pyenv/versions/miniconda3-4.3.30/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/keishish/.pyenv/versions/miniconda3-4.3.30/etc/profile.d/conda.sh" ]; then
            . "/home/keishish/.pyenv/versions/miniconda3-4.3.30/etc/profile.d/conda.sh"
        else
            export PATH="/home/keishish/.pyenv/versions/miniconda3-4.3.30/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

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
eval $DOTPATH/bin/backupenv # make backup of current env
source ~/.cleanup_envar.bash


echo "sucessfully sourced .zshrc"

# Launch and attach to tmux server
source ~/.tmux/tmuxautorun


