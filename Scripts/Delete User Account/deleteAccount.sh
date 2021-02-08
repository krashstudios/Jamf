#!/usr/bin/env zsh
# =============================================================================
# Script         : deleteAccount.sh
# Author(s)	     : Matthew Tanner
# Email          : matthew.tanner@mesacc.edu
# Date           : 02/14/2020
# Description    : Gets user input from terminal and asks what account name to delete.
# version        : 0.1
# =============================================================================
# Change Log     :
#        00/00/0000 -
# =============================================================================

# Gets name of the user account from terminal user input
  read -p  "What is the name of the user account you want to delete ? :" accountName

# Checks to see if user exist, if so verify its deletion. Otherwise if user acccount does not exist, exit.
  result="`dscl . -list /Users | grep $accountName`"
  if [ "$result" == $accountName ]; then
    while true; do
      read -p "Are you sure you want to delete the user account for \"$accountName\" ?  y | n :" choice
      case "$choice" in
        [yY][eE][sS]|[yY] ) sudo sysadminctl -deleteUser $accountName -secure;
                            echo "The user account \"$accountName\" has been deleted."; break;;
        [nN][oO]|[nN] ) echo "Account was not deleted."; exit;;
        * ) echo "Please enter y or n";;
      esac
    done
  else
    echo "User account \"$accountName\" does not exist"
  fi
exit 0
