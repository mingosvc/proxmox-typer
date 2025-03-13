# proxmox-typer
A simple script for AutoHotkey that allows to paste text in Proxmox web shell emulating pushed keys

How to use it: 

To open it you just need to double click on the file proxmox-typer.ahk or convert the file to executable with autohotkey and run it.

You can use the buttons available in the script window, but the following keyboard shortcuts make it much faster to use:
<Ctrl>+<Shift>+M to open the window in which the text is copied. 
<Ctrl>+V to paste the text into that window with or button.
<Ctrl>+Enter to store the text in memory (this closes the window automatically).
<Ctrl>+<Shift>+V to paste text into proxmox web shell 


The script loads the contents of the windows clipboard when the window is first displayed, and if any text has already been stored it loads the previously stored contents.

*Autohotkey only works on Windows
*This script works correctly when pasting text into the Proxmox web shell and LXCs, but does not yet work correctly when pasting text with punctuation characters into VMs.
