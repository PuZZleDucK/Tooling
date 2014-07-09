#!/bin/bash

# normal bash fountain
for((i=1; i>0; i++)) ; do  if [ $(($RANDOM % 2)) -eq 0 ]; then echo -e -n "\u2571"; else echo -e -n "\u2572"; fi; if [ $(($RANDOM % 6)) -eq 0 ]; then echo -e -n " "; fi; sleep 0.01    ; done


 
