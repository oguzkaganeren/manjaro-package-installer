# !/bin/bash
#
filename="$1"
pkglist=()
I=1;
for LN in $(cat packagelist.txt)
do
    #echo "$((I++)) $LN"
    pkglist+=("$LN" "$LN" "on")
done
if [[ $TERM == "linux" ]] && [[ -e /usr/bin/maia-console ]]; then
    export DIALOGRC="/usr/share/manjaro-architect/dialogrc"
else
    export DIALOGRC="/usr/share/manjaro-architect/dialogrc_gui"
fi

choices=`dialog --stdout --checklist "Choose Which Packages You Install:" 25 60 17 ${pkglist[@]}`
if [ $? -eq 0 ]
then
        for choice in $choices
        do
                echo "You chose: $choice"
        done
else
        echo cancel selected
fi
