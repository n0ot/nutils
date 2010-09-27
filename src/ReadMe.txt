How to use NUtils
This readme is for NUtils 3.0.
It is best that you view this readme in word wrap.


NUtils allows you to do many functions.
You can show and hide up to 10 windows with one keystroke. This allows you to get windows such as audio repeaters out of your way.
If 10 hidden Windows are not enough for you, you can increase the number of hidden Windows by creating another stack of windows with one keystroke.
You can also change the title of a window. This is nice when you have many windows with the same title such as audio repeaters and you want to make them easier to find.
You can make windows transparent so they can be hidden yet controlled by the user.
You can forcefully kill the current window for non-responding applications.
You can modify the code and restart NUtils without having to hunt for it or even without having AutoIt installed.
You can also configure a list of windows to be automatically killed when they are seen like "Skype™ - Receiving file. Done!".
You can hide a window in the first available slot with one keystroke.
You can bring up a list of all hidden windows and unhide the one you want, either via the system tray or a quick keystroke.
To learn how to use these functions and many others, read on.



Note: This readme asumes that you are using the default hotkey assignments.
If you have changed any hotkeys in hotkeys.ini, you will have to make a note of that when accessing those functions.
NUtils lets you hide and unhide up to 10 windows.
When pressing windows+shift+0-9, if there is no hidden window in that slot, the active window will be hidden.
If there is a hidden window in that slot, the hidden window will be shown.
These window states will be saved in a file called hiddenwindows in order to save their state in case NUtils is restarted.
For example, pressing windows+shift+1 will hide the active window. Pressing it again at anytime will unhide it.

If you need to hide more than 10 windows, press windows+shift+= to move to the next stack.
Windows+Shift+- will move to the previous stack.
The stack you are on will be indicated by the number of beeps that are played. For example, if you are on stack 2, you will hear 2 beeps.
You may use an unlimited number of stacks and each new stack will give you a fresh set of slots to hide more Windows.
So if you are on stack 2 and you press windows+shift+1, the current Window can be unhidden by going to stack 2 and pressing windows+shift+1.

Control+Alt+t: Change title of active window.
A text box will appear. At this time, all other NUtils functions will not be processed.
The current title will be already filled in.
Edit the title or enter a new one and click ok.

Windows+Shift+\: Make window transparent.
Windows+Shift+/: Make transparent window solid (visible).

Windows+Shift+Escape: Edit NUtils code.
This will pop up the AutoIt code in notepad. Make your changes, save them and then restart NUtils to execute the new code.

Windows+Escape: Restart NUtils.

Windows+f4: Forcefully kill the process of active window.
This is useful when a program is not responding or is making your system hang.
Instead of sending a close message, the process will be immediately ended.
Warning, when performing this task, your changes will not be saved. 

You may now exit NUtils and unhide hidden windows from the system tray.
To do so, right click the NUtils icon on the system tray and either click exit, about... or one of your hidden windows.

Another way to view your currently hidden windows is by pressing windows+shift+l. This will bring up a dialog showing all of your hidden windows. You can select the one you want and click unhide to unhide that particular window.
You can select a stack to unhide all the windows hidden in that stack.

To set the current window's process priority, press windows shift f3-windows shift f8
where windows shift f3=low, f4=below normal, f5=normal, f6=above normal, f7=high and f8=realtime.

If you want to hide a window but don't necessarily care where it is hidden, windows+shift+h will hide it in the first available slot. NUtils will start searching from the current stack onward.

By default, NUtils now uses the old-style stack beep notifications.
To enable the newer number-sounding stack notifications, edit settings.ini and change StackCounter from 1 to 0 under the settings section.
NUtils comes, by default, with the DTMF number pack. If you would like to download other number packs, see the NUtils page on the web site.
To change the language, set the value of language in settings.ini under the settings section to the language you wish to see messages in.
This language must be a supported language under lang.ini.

If you would like to create a list of Windows to be auto closed when they exist, edit winmurderer.ini
Let's, for example, have NUtils kill "Skype™ - Receiving file. Done!".
Create a new section by writing [skreceived]. Note, you may call the section name whatever you want.
Under that, write title=Skype™ - Receiving file. Done!
This title must match the title of the window exactly including case.
Under that, write degree=1.
degree=1 will forcefully kill the window.
degree=2 will kill the process associated with the window.


To check for updates, click the NUtils icon in the system tray and then click "Check for Updates..."

Other Notes:
When upgrading to a new version of NUtils, your previous ini's will be overridden.
Do not delete NUtils.au3.
To run NUtils, always run Nutilsload.exe
To call the API to hide and unhide windows from your AutoIt Script,
Include nutilsApi.au3
Then call _NUtils_ShowHide($handle) where $handle is the handle of the window you wish to hide.

If you wish to make this application smaller, you may delete the sounds. NUtils will produce PC speaker beeps instead.

If you wish for NUtils to run at startup, right click NUtilsload.exe and go to create shortcut. Then, right click Shortcut to NUtilsload.exe, click cut, and then right click the start button and click open all users.
Double click programs, then double click startup. Go to edit, and click paste.

Contacting:
NUtils can be found at http://www.arbalon.com.
You may contact either Niko Carpenter or Tyler Spivey via email.
Niko Carpenter (primary contact): nik62591@gmail.com
Tyler Spivey: tspivey@pcdesk.net


Credits:
     While I, Niko Carpenter, am the original coder for NUtils, I need to give credit to a few people who've helped me a lot along the way.
1. I give credit to Tyler Spivey, who has done most of the coding of NUtils other than myself.
     And for coming up with a great idea for the NUtils API/coding the NUtils API. He is the co-author of this program.
2. Justin Thornton, for giving me and Tyler the idea for stacks; without him, NUtils would still be limited to only 10 Windows. And to him for the process priority idea.
3. Matt King for the idea of Win+Shift+h, giving you the ability to just hide a window anywhere, and win+shift+l, allowing you to see and unhide your windows from anywhere.
4. And for everyone's great suggestions and feedback, and most importantly, your continued thanks and want to use NUtils has inspired me to work so much further than just suiting my needs.
     Remember, NUtils was once just one of my many personal scripts to make my life that much easier, one of those scripts that I would never release.

    NUtils is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    NUtils is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with NUtils.  If not, see http://www.gnu.org/licenses/.
