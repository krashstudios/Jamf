# GlobalProtect Uninstaller Fix

GlobalProtect Uninstaller Fix supplements paloalto's macOS GlobalProtect uninstaller to fix the call to remove the programs Keychain entry. The original line of code calls the Keychain service as GlobalProtect but should be calling it as GlobalProtectService.

###  Original line of code

<pre>
	<code>
247...	#remove password entry from keychain
248...	security delete-generic-password -l <strong style="color:red;">GlobalProtect</strong> -s <strong style="color:red;">GlobalProtect</strong> "${CONSOLE_HOME}/Library/Keychains/login.keychain-db"
	</code>
</pre>

## The Fix
The script checks what version of GlobalProtect is installed and then searches the uninstaller script found in */Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh* for the line that deletes the Keychain entry. (This line has changed in various versions of the program). Once the version is identified the script injects the propper Keychain call `GlobalProtectService`.

### Corrected line of code

<pre>
	<code>
247...	#remove password entry from keychain
248...	security delete-generic-password -l <strong style="color:red;">GlobalProtectService</strong> -s <strong style="color:red;">GlobalProtectService</strong> "${CONSOLE_HOME}/Library/Keychains/login.keychain-db"
	</code>
</pre>

![](https://github.com/krashstudios/Jamf/raw/master/Scripts/Global%20Protect%20Uninstaller%20Fix/img/Screen%20Shot%202021-02-05%20at%201.55.36%20PM.png)






