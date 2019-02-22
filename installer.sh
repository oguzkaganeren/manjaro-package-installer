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
notInstalledPkgs=()
        for choice in $choices
        do
		if pacman -Qs $choice > /dev/null ; then
		  echo "The package $choice is installed"
		else
		  echo "The package $choice is not installed"
		  notInstalledPkgs+=" "$choice
		fi
        done
sudo pacman -S $notInstalledPkgs
else
        echo cancel selected
fi
