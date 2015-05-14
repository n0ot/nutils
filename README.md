# NUtils Readme

NUtils is copyright© 2008-2010 Arbalon, Niko Carpenter, and Tyler Spivey.  
 Web site: [http://www.arbalon.com].

## 1: Introduction

### 1.1: What is NUtils?

NUtils is a hotkey-controled Window manager, to extend the functionality of Windows to increase productivity.

### 1.2: Features

Below is a summary of NUtil's feature set:

*   Show/hide up to 10 windows with one keystroke
*   Create multiple "stacks" of windows--for those times when more than 10 windows need to be hidden). Switch between these stacks with a simple keystroke.
*   Change the title of any window--to easily sort through windows whose titles are the same by default.
*   Make a window transparent--to protect against nosy onlookers; to interact with the window, a screen reader must be used.
*   Forcefully kill the current window for non-responding applications.
*   Automatically close windows that exist in a list, or kill the process associated with them.
*   Get a list of all hidden windows in an organized tree.

### 1.3: Installing

#### 1.3.1: Installing from the self-extracting archive

To install NUtils from the self-extracting archive, Run NUtils-portible.exe and extract NUtils in the desired location. A folder called NUtils will be created. To run NUtils, go into the newly created folder and run NUtils.exe.

#### 1.3.2: Installing NUtils with the installer

To install NUtils using the installer, to get desktop and start menu shortcuts, run NUtils_Setup.exe and follow the instructions. To start NUtils, double click the NUtils shortcut that has been placed on your desktop, or in your start menu.

#### 1.3.3: Configuring NUtils to run at startup.

To configure NUtils to run at startup, if using the installed copy, right click the shortcut to NUtils on your desktop and click copy. Next, right click the start button and click open all users, or just open if you only wish for NUtils to start up under your user account. Double click Programs, and then double click Startup. Right click a blank area in this folder and click paste. If you are using the portible copy, make sure that it is not on a removeable drive as NUtils will not start if this drive is not plugged in when the computer is started. In the NUtils folder, right click NUtils.exe and click create shortcut. A shortcut will be created in the same folder. Right click this shortcut and click cut. Next, right click the start button and click open all users, or just open if you only wish for NUtils to start up under your user account. Double click Programs, and then double click Startup. Right click a blank area in this folder and click paste.

## 2: Using NUtils

Note: This readme asumes that you are using the default hotkey assignments. If you have changed any hotkeys in hotkeys.ini, you will have to make a note of that when accessing those functions.

### 2.1: Hiding and unhiding windows using the number ro

If there are several windows open, it can be useful to hide them, so that they aren't taking up room on your taskbar, or in your alt+tab order. This could be to hide a window that you wish to keep open but aren't really doing much with, such as a media player, or notepad with some notes that you wish to access later, or to hide a window so it can be easily recalled, like a document or web page.

To hide a window, place your focus into the window you wish to hide, either by clicking your mouse into it, clicking its icon on the taskbar, or alt+tabbing to it. Next, hold down control and shift, and press any number on the number row. To try this, go to any window and press control+shift+1\. Notice that the window you were in is no longer visible. Now, go ahead and do some things on your computer. Whenever you want to get that window back, just press control+shift+1 again, and the window will reappear.

In summary, if you remain on the same stack--stacks will be explained in the next section, pressing control+shift and any number will hide the active window, unless there is a window already hidden in that "slot," in which case that hidden window will be "unhidden" and will gain focus. Note that control+shift+0 is actually slot 10, not slot 0.

At times, it is useful to be able to hide the active window without having to find a free slot to hide it in--sometimes, you don't care where a window is hidden; you just want it hidden. If you want to hide a window, but do not necessarily care which slot it goes into, press windows+shift+h, and NUtils will hide it in the first available slot. Note that the first available slot is calculated starting on your current stack, so if you're on stack 3 and you press windows+shift+h, NUtils will start searching at stack 3, slot 1, to find the first slot that is free. This may mean that your window will be hidden on the next stack, if the current stack is full.

### 2.2: Working with stacks

If you want to work with more than ten windows, or you simply wish to be a little bit more organized with the way you hide your windows, you can create a new stack, giving you ten blank slots to hide windows in. A stack is a set of ten slots in which to hide and or unhide windows. By default, you are on stack 1\. To go to the next stack, press control+shift=. To go to the previous stack, press control+shift+-.

A common use for stacks, other than for hiding more than ten windows, is to hide different types of applications on different stacks. For example, you might want to leave stack 1 open for things that you will frequently access like your media player, web pages, installations, etc. However, you have a bunch of Audio Repeaters open--Audio Repeater is a program used to pass audio from the input device of one soundcard and output it onto another sound card, and you wish to hide them. When you have five copies of Audio Repeater open, it is very handy to have them hidden, because you don't really need to do much with them besides leaving them open, but you don't want them in your way. However, you don't want them cluttering up your first stack, where you like to hide the windows that you actually need to do something with. So you switch to stack 2, hide your Audio Repeaters, and then switch back to stack 1.

Just be aware that you cannot unhide a window that is on a different stack by pressing control+shift+its number; you will first need to switch back to that stack and then unhide it. By default, NUtils will inform you of what stack you are on when you switch to it by beeping x number of times, where x is the stack you've switched to. For example, when switching to stack 2, NUtils will beep twice. This behavior can be changed by editing settings.ini, and under the settings section, changing StackCounter=1 to StackCounter=0\. With this set, NUtills will use a number pack to announce which stack you are switching to. By default, NUtils comes with the DTMF number pack, but other number packs can be found on the download page for NUtils.

### 2.3: Hidden Window List

NUtils provides a list of all hidden windows, organized in a tree structure. Press windows+shift+l to recall this list. Hidden windows are organized by stack. To unhide a window, click the window you wish to unhide, and then click the unhide button in the lower left-hand corner of the dialog. You will notice that NUtils will automatically give focus to the last window you hid, so an easy way to unhide the last hidden window is to press windows+shift+l and when the list comes up, press enter. A history of all of your hidden windows is kept, so you could for example, press windows+shift+h to hide several windows, and then press windows+shift+l, then enter, and each time you do that, your windows will be unhidden in reverse order. This history is not kept after NUtils is restarted.

### 2.4: Making windows transparent

There are times where you might find yourself in a situation in which you wish to interact with a window, yet you don't want the window to be visible on the screen. To make a window transparent, press windows+shift+\. To make the window solid again, press windows+shift+/. To interact with this window, you will need a screen reader. The act of making a window transparent throws off some screen readers that use display hooking, so there are limits to the use of this feature.

### 2.5: Changing the Process Priority of the Active Window

If, for whatever reason, you wish to change the process priority of the active window, press control+shift+f3-f8, where f3 is low, f4 is below normal, f5 is normal, f6 is above normal, f7 is high, and f8 is realtime. A beep, pitched higher for higher priorities, will be played to let you know that the priority has been changed. If it could not be changed, a low beep will play, indicating that the process priority could not be changed.

## 3: Other notes

### 3.1: Limitations

NUtils cannot perform actions on windows that it doesn't have permission to act upon. As a consequence, if NUtils is running normally, it cannot hide, change the process priority, or make transparent windows that are running with elevated privileges.

### 3.2: Reducing the Size of NUtils

If you want to make the NUtils package smaller, you can remove the sounds folder. NUtils will instead produce PC speaker beeps in place of the sounds that would have been played otherwise.

### 3.3: The NUtils API

There is a basic API to control NUtils. This API will allow your application to pass the handle of a window to NUtils. NUtils will find the first available slot starting from stack 1, and hide that window in that slot. When your application calls the NUtils API with the same parameters, NUtils will unhide that window. An AutoIt include file, NUtilsApi.au3, can be found in the NUtils folder. To use the API in your application, just include NUtilsApi.au3, and call _NUtils_ShowHide($handle) where $handle is the handle of the window you wish to hide.

## 4: Contact us

You may contact either Niko Carpenter or Tyler Spivey via email:

<dl>

<dt>Niko Carpenter (primary contact)</dt>

<dd>nik62591@gmail.com</dd>

<dt>Tyler Spivey</dt>

<dd>tspivey@pcdesk.net</dd>

</dl>

## 5: Credits

While I, Niko Carpenter, am the original coder for NUtils, I need to give credit to a few people who've helped me a lot along the way.

1.  I give credit to Tyler Spivey, who has done most of the coding of NUtils other than myself. And for coming up with a great idea for the NUtils API/coding the NUtils API. He is the co-author of this program.
2.  Justin Thornton, for giving me and Tyler the idea for stacks; without him, NUtils would still be limited to only 10 Windows. And to him for the process priority idea.
3.  Matt King for the idea of Win+Shift+h, giving you the ability to just hide a window anywhere, and win+shift+l, allowing you to see and unhide your windows from anywhere.
4.  And for everyone's great suggestions and feedback, and most importantly, your continued thanks and want to use NUtils has inspired me to work so much further than just suiting my needs.

Remember, NUtils was once just one of my many personal scripts to make my life that much easier, one of those scripts that I would never release.

## 6: License

NUtils is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

NUtils is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with NUtils. If not, see [http://www.gnu.org/licenses/].