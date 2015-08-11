#!/bin/bash

read -p "Instaling packages from 'program-list.txt'. <ctrl>-c to cancel..."

#while read line ; do
for line in `cat program-list.txt` ; do
#  if [[ "$line" != "" ]] ; then
    echo -e "\nINSTALLING: $line"
    sudo apt-get install $line
#  fi
done

