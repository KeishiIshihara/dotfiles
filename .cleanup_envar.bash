#!/bin/bash
# ----------------------------------------------------------------
#  This will crean up dupricated environment variable paths.
#
#  Usage: at the last line in your zsh or similar runcommand file,
#       source .cleanup_envar.bash
#
#  Then finish!
#  Note that this is for only linux os currently.
#
#  (c) Keishi Ishihara
# ----------------------------------------------------------------

# TODO:
# - [x] make it compatible with macOS also: `env -0` is not avairable on macOS
# - [x] procude a backup file of the Env Var before cleaning up them just in case


os_detect() {
    if [ "$(whoami)" = 'ishiharakeishi' ]; then
        # export PLATFORM
        PLATFORM='osx'
    elif [ "$(whoami)" = 'keishish' ]; then
        PLATFORM='dluef-kde'
    elif [ "$(whoami)" = 'aisl' ]; then
        PLATFORM='aisl-pc'
    else
        PLATFORM='unknown'
    fi
}

# os_detect() {
#     export PLATFORM
#     case "$(uname)" in
#         'Darwin')   PLATFORM='osx'     ;;
#         'Linux')    PLATFORM='linux'   ;;
#         *'bsd'*)    PLATFORM='bsd'     ;;
#         *)          PLATFORM='unknown' ;;
#     esac
# }


os_detect
# echo $PLATFORM
is_successed=0

declare -a envar=()
ln=0

if [ $PLATFORM = 'dluef-kde' ]; then
    for i in `env -0 | tr '\r\n' ' ' | sed 's/\x0/\n/g' | sed 's/=.*//'`
    do
        # echo $ln; echo $i
        envar+=("$i") # store the value of variable as one "element"
        ln=$((++ln)) # equivalent to let ln++
    done

    for var in "${envar[@]}"; do
        # echo 'ENVAR: '$var
        # echo "- old path:"
        # eval echo \"\$$var\"
        # echo "- new path:"
        new_path=$(eval echo \"\$$var\" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
        # echo $new_path
        # echo "- executed command:"
        command="export $(echo $var)=\"$new_path\""
        # echo $command
        eval $command
        # echo "- result"
        # eval echo \"\$$var\"
        # echo "---"
    done
    is_successed=1

elif [ $PLATFORM = 'osx' ]; then
    for i in `env | sed 's/=.*//'`
    do
        # echo $ln; echo $i
        envar+=("$i") # store the value of variable as one "element"
        ln=$((++ln)) # equivalent to let ln++
    done

    for var in "${envar[@]}"; do
        new_path=$(eval echo \"\$$var\" | tr ':' '\n' | awk  'a[$0]++ == 0' | tr '\n' ':' | sed '$s/.$//')
        command="export $(echo $var)=\"$new_path\""
        eval $command
    done
    is_successed=1


elif [ $PLATFORM = 'aisl-pc' ]; then
    echo 'this is aisl-pc'
    echo 'this isn'\'' t enabled yet.'
    # for i in `env -0 | tr '\r\n' ' ' | sed 's/\x0/\n/g' | sed 's/=.*//'`
    # do
    #     # echo $ln; echo $i
    #     envar+=("$i") # store the value of variable as one "element"
    #     ln=$((++ln)) # equivalent to let ln++
    # done

    # for var in "${envar[@]}"; do
    #     new_path=$(eval echo \"\$$var\" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
    #     command="export $(echo $var)=\"$new_path\""
    #     eval $command
    # done
    is_successed=0
else
    echo 'this is unknown pc'
    is_successed=0
fi

if [ $is_successed = 1 ]; then
    echo 'Congrats! Cleaned up every single env variables!'
    echo '(Please ignore if Runtime error occured from awk command)'
else
    echo '[WARNING] It went something wrong with cleaning up env variables.'
    echo '          Please check dotfiles/.cleanup_envar.bash'
fi



# PATH:
# /Users/ishiharakeishi/.pyenv/shims
# /Users/ishiharakeishi/.pyenv/bin
# /Users/ishiharakeishi/bin
# /Users/ishiharakeishi/Library/Python/2.7/bin
# /usr/local/bin
# /Users/ishiharakeishi/.tmux/bin
# /usr/bin
# /bin
# /usr/sbin
# /sbin
