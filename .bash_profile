# iTerm color preference
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

export PATH="$HOME/Library/Python/2.7/bin:$PATH"

export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="$HOME/.pyenv/shims:$PATH"

export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0
function startx() {
    if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then
        open -a XQuartz
        socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
    fi
}

export PATH="/usr/local/bin:$HOME/bin:$PATH"

if [ -f ~/.zshrc ]; then
	source ~/.zshrc
    echo ".zshrcをsourceしました."
elif [ -f ~/.bashrc ]; then
	source ~/.bashrc
    echo ".bashrcをsourceしました."
fi

