#!/bin/bash


function isColor {
    lol=`which lolcat`;
    if [[ $lol ]] ; then
	return 0;
    else
	return 1;
    fi    
}

function title {
    r=$(( RANDOM % 500 ));
    if isColor ; then
	echo -e "\n#############################" | lolcat --seed $r ;
	echo -e "# Category: ${1:1}" | lolcat --seed ${r+1} ;
	echo -e "#############################" | lolcat --seed ${r+2} ;
    else
	echo -e "\n#############################"
	echo -e "# Category: ${1:1}"
	echo -e "#############################"
    fi
  
  
}

function install {
    status=`dpkg-query -W $1 2> /dev/null` # if installed there will be a version number
#    echo " status: ${status}"
#    echo " status2: ${#status}"
#    echo "    cmd2: $((${#1}+1))"
#        potential=`sudo apt-get install --simulate $1 2> /dev/null`
    if [[ "${#status}" == "$((${#1}+1))" ]] ; then # package is avaliable and uninstalled
        echo -e "# INSTALLING: $1" | tee -a ~/install.log
        sudo apt-get install --yes --force-yes --install-suggests $1 2>&1 | tee -a ~/install.log
    else
        if [[ "${#status}" == "0" ]] ; then
            echo "# Skip-no-candidate: $1" | tee -a ~/install.log
	else
            echo "# Skip-installed: $1" | tee -a ~/install.log
	fi    
    fi
}




read -p "Instaling packages from 'program-list.txt'. <ctrl>-c to cancel..." | tee ~/install.log
date | tee -a ~/install.log

for line in `cat program-list.txt` ; do
#  echo -e "Line{1}: ${line:0:1}"
  if [[ "${line:0:1}" != "#" ]] ; then
    install "$line"
  else
    title "$line"
  fi
done


