# umask 022
# limit coredumpsize 0
# bindkey -d

# # Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

# # tmux_automatically_attach attachs tmux session
# # automatically when your are in zsh
# if [[ -x ~/bin/tmuxx ]]; then
#     ~/bin/tmuxx
# fi

# if [[ -f ~/.zplug/init.zsh ]]; then
#     export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
#     source ~/.zplug/init.zsh

#     if ! zplug check --verbose; then
#         printf "Install? [y/N]: "
#         if read -q; then
#             echo; zplug install
#         fi
#         echo
#     fi
#     zplug load
# fi

# if [[ -f ~/.zshrc.local ]]; then
#     source ~/.zshrc.local
# fi

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/vault vault

# # 環境変数
# export LANG=ja_JP.UTF-8

# # ヒストリの設定
# HISTFILE=~/.zsh_history
# HISTSIZE=10000
# SAVEHIST=10000
# # 直前のコマンドの重複を削除
# setopt hist_ignore_dups
# # 同じコマンドをヒストリに残さない
# setopt hist_ignore_all_dups
# # 同時に起動したzshの間でヒストリを共有
# setopt share_history

# # 補完機能を有効にする
# autoload -Uz compinit
# compinit -u
# if [ -e /usr/local/share/zsh-completions ]; then
#   fpath=(/usr/local/share/zsh-completions $fpath)
# fi
# # 補完で小文字でも大文字にマッチさせる
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# # 補完候補を詰めて表示
# setopt list_packed
# # 補完候補一覧をカラー表示
# zstyle ':completion:*' list-colors ''

# # コマンドのスペルを訂正
# setopt correct
# # ビープ音を鳴らさない
# setopt no_beep

# # prompt
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
# zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd() { vcs_info }
# PROMPT='%m:%F{green}%~%f %n %F{yellow}$%f '
# RPROMPT='${vcs_info_msg_0_}'

# # alias
# alias ls='ls -aF'
# alias ll='ls -l'
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# alias vi='vim'
# alias cat='cat -n'
# alias less='less -NM'
# export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad

# # source ~/.bashrc

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# 色を使用
autoload -Uz colors
colors

# 補完
# autoload -Uz compinit
autoload -U compinit
compinit

# emacsキーバインド
bindkey -e

# 他のターミナルとヒストリーを共有
setopt share_history

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

# コマンドミスを修正
setopt correct


# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'


## エイリアス
# enable color support of ls
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
fi

alias so='source'
alias sz='source ~/.zshrc'
alias v='vim'
# alias vi='vim'
alias vz='vim ~/.zshrc'
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
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias l='ls -1F'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls

# another alias files
# source ~/.ros_setup
source ~/.aisl_ssh_list


# backspace,deleteキーを使えるように
stty erase ^H
bindkey "^[[3~" delete-char

# cdの後にlsを実行
chpwd() { ll }

# どこからでも参照できるディレクトリパス
cdpath=(~)

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control


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

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

# # git設定
# RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# RPROMPT=$'${vcs_info_msg_0_}'

# プロンプトを2行で表示、時刻を表示
# PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~ "

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

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/.tmuxinator/tmuxinator.zsh
source ~/.tmuxautorun
export PATH="$HOME/Library/Python/2.7/bin:$PATH"
