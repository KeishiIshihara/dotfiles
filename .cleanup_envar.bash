#!/bin/bash
# ----------------------------------------------------------------
#  This will crean up dupricated environment variable paths.
#  
#  Usage: at the last line in your zsh or similar runcommand file,
#       source .cleanup_envar.bash
#
#  Then finish!   
#
#
#  (c) Keishi Ishihara
# ----------------------------------------------------------------


declare -a envar=()
ln=0
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

echo 'Congrats! Cleaned up every single env variables'\'' name!'

