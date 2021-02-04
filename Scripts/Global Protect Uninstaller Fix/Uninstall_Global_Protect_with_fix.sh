#! /bin/zsh

## Script name:		Uninstall_Global_Protect_with_fix.sh
## Author:        	Matthew Tanner (matthew.tanner@mesacc.edu)
## Last Modified:	07-08-2020
##                  01-07-2021 - Added fix for 5.1.6-16 and 5.2.4-21

## Description:		Searches the GlobalProtect Uninstaller script and replaces
##					"GlobalProect" with "GlobalProtectService" to update the
##					keychain name. Code line changes depending on app version.

## Code to get Global Protect version information: (Added both ways in case updates break the current one in use)
## cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'
## or
## mdfind -0 -onlyin /Applications "kMDItemKind == Application && kMDItemCFBundleIdentifier = com.paloaltonetworks.GlobalProtect.*" | xargs -0 mdls -name kMDItemVersion

# fixes the remove password entry from keychain name from "GlobalProtect" to "GlobalProtectService" so that it removes from keychain
if [[ `cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'` =~ "5.0.9-15" ]]; then
    echo "version = 5.0.9-15"
    sudo perl -i -pe 's/GlobalProtect/GlobalProtectService/g if $.==190' /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
elif [[ `cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'` =~ "5.1.1-12" ]]; then
    echo "version = 5.1.1-12"
    sudo perl -i -pe 's/GlobalProtect/GlobalProtectService/g if $.==195' /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
elif [[ `cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'` =~ "5.1.5-20" ]]; then
    echo "version = 5.1.5-20"
    sudo perl -i -pe 's/GlobalProtect/GlobalProtectService/g if $.==248' /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
elif [[ `cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'` =~ "5.1.6-16" ]]; then
    echo "version = 5.1.6-16"
    sudo perl -i -pe 's/GlobalProtect/GlobalProtectService/g if $.==248' /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
elif [[ `cat /Applications/GlobalProtect.app/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'` =~ "5.2.4-21" ]]; then
    echo "version = 5.2.4-21"
    sudo perl -i -pe 's/GlobalProtect/GlobalProtectService/g if $.==248' /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
else
    echo "Could not determine GlobalProtect version, unable to patch uninstaller."
fi

## Origianl script that calls Global Protect's uninstall script in /Applications/GlobalProtect.app/Resources/uninstall_gp.sh
pathToScript=$0
pathToPackage=$1
targetLocation=$2
targetVolume=$3

# calls uninstall script within the GlobalProtect.app
sudo /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh

exit 0		## Success
exit 1		## Failure