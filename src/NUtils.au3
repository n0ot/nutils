#cs
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
#ce

#include "include\Inet.au3"
FileChangeDir(@ScriptDir)
$winname = "ArbalonNUtilsWND"
if @Compiled Then NUtilsLoad()
Global $lang = INIRead("settings.ini", "settings", "language", "eng")
Global $StackCounter=INIRead("settings.ini", "settings", "StackCounter", "1")

Const $Info_Version="3.1"
Const $Info_Authors = "Niko Carpenter "&_t("and")&" Tyler Spivey"
Const $Info_WebSite = "http://www.arbalon.com"
if $cmdline[0] < 1 Then Exit
if $cmdline[1] = "CheckForUpdatesQuiet" Then
CheckForUpdates(true)
Exit
ElseIf $cmdline[1] = "CheckForUpdates" Then
CheckForUpdates(false)
ElseIf $cmdline[1] = "nutils" Then
Else
Exit
EndIf
global $hiddenwindows[1] = ["x"]
Global Const $GUI_FOCUS = 256
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_DISABLE = 128
AutoItSetOption("WinTitleMatchMode", 4)
autoitSetOption("TrayAutoPause", 0)
autoItSetOption("TrayOnEventMode", 1)
autoitSETOption("trayMenuMode", 1)
TraySetTooltip("NUtils")
global $tid_exit = TrayCreateItem(_t("Exiticon"))
global $tid_lng = trayCreateItem(_t("SelectLanguage") & " (Select Language)...")
global $tid_Checkforupdates = trayCreateItem(_t("CheckForUpdates")&"...")
global $tid_about = trayCreateItem(_t("About")&"...")
TrayCreateItem("")
trayItemSetOnEvent($tid_exit, "trayEvent")
trayItemSetOnEvent($tid_lng, "trayEvent")
trayItemSetOnEvent($tid_Checkforupdates, "trayEvent")
trayItemSetOnEvent($tid_about, "trayEvent")
global $shift = 0
$hwFile = @TempDir & "\NUtils_Hiddenwindows"
While WinExists($winname)
WinKill($winname)
Wend
Global $hk_bass=INIRead("hotkeys.ini", "hotkeys", "bass", "^+")
Global $hk_stackdown=INIRead("hotkeys.ini", "hotkeys", "stackdown", "^+-")
Global $hk_stackup=INIRead("hotkeys.ini", "hotkeys", "stackup", "^+=")
Global $hk_chtitle=INIRead("hotkeys.ini", "hotkeys", "chtitle", "#+t")
Global $hk_transparent=INIRead("hotkeys.ini", "hotkeys", "transparent", "#+\")
Global $hk_solid=INIRead("hotkeys.ini", "hotkeys", "solid", "#+/")
Global $hk_firstavailhide=INIRead("hotkeys.ini", "hotkeys", "firstavailhide", "#+h")
Global $hk_winls=INIRead("hotkeys.ini", "hotkeys", "winls", "#+l")
Global $hk_winkill=INIRead("hotkeys.ini", "hotkeys", "winkill", "#{f4}")
Global $hk_reload=INIRead("hotkeys.ini", "hotkeys", "reload", "#{esc}")
Global $hk_edit=INIRead("hotkeys.ini", "hotkeys", "edit", "#+{esc}")
Func NUtilsLoad()
if WinExists($WinName) Then Exit
If not FileExists(StringTrimRight(@ScriptFullPath, 3) & "au3") Then Exit
if not FileExists(@ScriptFullPath) Then Exit
Run(@ScriptFullPath&" /autoit3executescript """ & StringTrimRight(@ScriptFullPath, 3) & "au3"" nutils")
Exit
EndFunc

func min($n1, $n2)
if $n1 < $n2 then
return $n1
else
return $n2
endIf
endFunc
func max($n1, $n2)
if $n1 > $n2 then
return $n1
else
return $n2
endIf
endFunc
AutoItWinSetTitle($winname)
$win = FileRead($hwFile, FileGetSize($hwFile))
$semiindex = StringInStr($Win, ";")
if $semiindex > 0 Then
$Sysup = StringLeft($Win, $Semiindex-1)
Else
$Sysup = ""
EndIf
$updiff = $sysup-GetUpEpoch()
if not StringIsInt($Sysup) or $updiff > 10 or $updiff < -10 Then
$Win = ""
Else
$Win = StringTrimLeft($Win, $Semiindex)
EndIf
$Windows2 = StringSplit($win,";")
if $windows2[0] = 0 Then
Global $windows[10] = [0,0,0,0,0,0,0,0,0,0]
Else
Global $windows[max($windows2[0], 10)]
for $i = 1 to $windows2[0]
$Windows[$i-1] = hwnd($windows2[$i])
next
for $i = 0 to ubound($windows)-1
if $windows[$i] = "" then
$windows[$i] = 0
endIf
Next
$windows2 = ""
EndIf
for $i = 0 to ubound($windows)-1
if $windows[$i] <> "" then
historyAdd($i)
endIf
next
global $trayids[ubound($windows)]
createTrayItems()
guiCreate($winname&"_api")
guiRegisterMsg(0x0501, "api")
If FileExists(StringTrimRight(@ScriptFullPath, 3) & "exe") and FileExists(@ScriptFullPath) Then
Run(StringTrimRight(@ScriptFullPath, 3) &"exe /autoit3executescript """ & StringTrimRight(@ScriptFullPath, 3) & "au3"" CheckForUpdatesQuiet")
EndIf
While 1
$ChangedWin = 0
for $i = 0 to ubound($windows)-1
if $windows[$i] <> hwnd(0) Then
If WinExists($windows[$i]) = 0 or BitAnd(WinGetState($Windows[$i]), 2) Then
$windows[$i] = hwnd(0)
historyDel($i)
If FileExists("Sounds\Disappear.wav") Then Soundplay("sounds\Disappear.wav")
$ChangedWin = 1
EndIf
EndIf
Next
if $ChangedWin = 1 Then SaveHiddenWindowState()
hotkeys(1)
$WinMurderer = 0
$WinMurderer = INIReadSectionNames("WinMurderer.ini")
if not @Error Then
for $i = 1 to $WinMurderer[0]
if WinExists(INIRead("WinMurderer.ini", $WinMurderer[$i], "title", "Win_Error_PLZDontKillMe")) Then
$Degree = INIRead("WinMurderer.ini",$WinMurderer[$i], "degree", 0)
If $Degree = 1 Then
WinKill(INIRead("WinMurderer.ini", $WinMurderer[$i], "title", "Win_Error_PLZDontKillMe"))
ElseIf $Degree = 2 Then
ProcessClose(WinGetProcess(INIRead("WinMurderer.ini", $WinMurderer[$i], "title", "Win_Error_PLZDontKillMe")))
Else
EndIf
EndIf
Next
EndIf
Sleep(1000)
Wend
Func Main()
hotkeys(0)
if @HotKeyPressed = $hk_chtitle Then
SetT()
ElseIf @HotKeyPressed = $hk_winkill Then
end()
EndIf
hotkeys(1)
EndFunc
Func Slot2Human($Slot)
$Slot += 1
Return $Slot
EndFunc
Func Human2Slot($Human)
if $human = 0 Then $Human = 10
$Human -= 1
Return $Human
EndFunc

Func End()
ProcessClose(WinGetProcess("[ACTIVE]"))
if FileExists("Sounds\kill.wav") Then
Soundplay("sounds\kill.wav")
Else
Beep(60, 300)
EndIf
EndFunc
Func SetT()
hotkeys(0)
AutoItSetOption("WinTitleMatchMode", 2)
local $txt
$ltitle = WinGetTitle("")
Sleep(200)
$txt = InputBox(_t("SetTitleTitle"),_t("SetTitleMessage"),$ltitle)
if @Error or $txt = "" Then
Else
$time = TimerInit()
$f = 0
While TimerDiff($Time) < 3000
if WinActive($lTitle) Then
$f = 1
ExitLoop
EndIf
Wend
if $f = 1 Then
WinSetTitle("","",$TXT)
Else
EndIf
EndIf
AutoItSetOption("WinTitleMatchMode", 4)
hotkeys(1)
EndFunc
func WinShowHide()
hotkeys(0)
$num = Human2Slot(int(stringRight(@hotKeyPressed, 1)))+$shift
$u = ubound($windows)
if $u-1 < $num then
redim $windows[$num+1]
for $i = $u to ubound($windows)-1
$windows[$i] = 0
next
endIf
$Handle = HWND($windows[$num])
if $Handle = "0x00000000" Then $Handle = Hwnd(WinGetHandle("[active]"))
ShowHideWin($Handle, $num)
hotkeys(1)
endFunc
Func Reload()
if FileExists(@ScriptFullPath) and FileExists(StringTrimRight(@ScriptFullPath, 3) & "exe") Then
if FileExists("Sounds\restart.wav") Then
Soundplay("sounds\restart.wav", 1)
Else
Beep(400, 40)
Beep(600, 40)
Beep(2400, 80)
EndIf
Run(StringTrimRight(@ScriptFullPath, 3) & "exe /autoit3executescript """ & @ScriptFullPath & """ nutils")
Exit
EndIf
EndFunc
Func EditScript()
if FileExists(@ScriptFullPath) and FileExists(@SystemDir&"\notepad.exe") Then
Run(@SystemDir&"\notepad.exe "&@ScriptFullPath)
EndIf
EndFunc
Func GetUpEpoch()
local $systimeStruct = _date_Time_GetSystemTimeAsFileTime()
$systime = 0
$ret = DLLCall("ntdll.dll", "int", "RtlTimeToSecondsSince1970", "ptr", DLLStructGetPTR($SystimeStruct), "uint*", $systime)
$systime = 0
$systimeStruct = 0
return $ret[2]-Floor(_date_Time_GetTickCount()/1000)
EndFunc

Func ShowHideWin($Handle, $num)
$Handle = hwnd($Handle)
if $windows[$num] = 0 then
if $handle = WinGetHandle("[class:Progman]") or $handle = WinGetHandle("[class:Shell_TrayWnd]") Then
If FileExists("Sounds\HideEr.wav") Then
Soundplay("sounds\HideEr.wav")
Else
Beep(70, 100)
EndIf
Else
if FileExists("Sounds\windown.wav") Then
Soundplay("sounds\windown.wav")
Else
Beep(1500, 100)
EndIf
winSetState($Handle, "", @SW_Minimize)
winSetState($Handle, "", @SW_HIDE)
$windows[$num] = $Handle
historyAdd($num)
EndIf
Else
 ;it exists, so show it and zero the value
winSetState($handle, "", @SW_SHOW)
winActivate($handle)
$windows[$num] = 0
historyDel($num)
if FileExists("Sounds\winup.wav") Then
Soundplay("sounds\winup.wav")
Else
Beep(1500, 50)
Sleep(50)
Beep(1500, 50)
EndIf
EndIf
SaveHiddenWindowState()
EndFunc
Func SaveHiddenWindowState()
cleanArray()
$write = ""
for $i = 0 to ubound($windows)-1
$Write &= ";"&$windows[$i]
Next
$Write = GetUpEpoch()&$Write
FileDelete($hwFile)
FileWrite($hwFile, $Write)
createTrayItems()
EndFunc
func api($hwnd, $msg, $wParam, $lParam)
if $msg = 0x0501 Then
$LParam = HWND($LParam)
$num = -1
;show the window if it exists
for $i = 0 to uBound($windows)-1
if $windows[$i] = $lParam Then
showHideWin($LParam, $i)
return
EndIf
Next
$Num = FindFirstAvailableSlot($Shift)
if $num = -1 then
redim $windows[ubound($windows)+1]
$num = ubound($windows)-1
endIf
if $num > -1 and WinExists($lParam) and $num <= uBound($Windows)-1 then
showHideWin($lparam, $num)
endIf
EndIf
endFunc
func shiftUp()
hotkeys(0)
$shift+=10
StackNotify()
hotkeys(1)
endFunc
func shiftDown()
hotkeys(0)
if $shift - 10 < 0 then
$shift = 0
else
$shift-=10
endIf
StackNotify()
hotkeys(1)
endFunc
func cleanArray()
$lastElement = -1
for $i = 0 to ubound($windows)-1
if hwnd($windows[$i]) <> "0x00000000" then
$lastElement = $i
endIf
next
if $lastElement > 9 then
reDim $windows[$lastelement+1]
else
redim $windows[10]
endIf
endFunc
func createTrayItems()
for $i = 0 to ubound($trayids)-1
if $trayids[$i] <> 0 and $trayids[$i] <> "" then
trayItemDelete($trayids[$i])
endIf
next
dim $trayids[ubound($windows)]
for $i = 0 to ubound($windows)-1
if hwnd($windows[$i]) <> "0x00000000" then
$trayids[$i] = trayCreateItem(Slot2Human($i)&": "&wingetTitle(hwnd($windows[$i])))
TrayItemSetOnEvent($trayids[$i], "trayEvent")
endIf
next
endFunc
func trayEVENT()
$item = 0
select
case @tray_id = $tid_lng
SelectLanguage()
case @tray_id = $tid_about
HotKeys(0)
	msgbox(4096, _t("About")&" NUtils", "Arbalon NUtils "&$Info_Version&@CRLF&_t("WrittenBy")&" "&$Info_Authors&"."&@CRLF&_t("WebSite")&": "&$Info_Website)
HotKeys(1)
case @tray_id = $tid_exit
exit
case @tray_id = $tid_Checkforupdates
If FileExists(StringTrimRight(@ScriptFullPath, 3) & "exe") and FileExists(@ScriptFullPath) Then
Run(StringTrimRight(@ScriptFullPath, 3) &"exe /autoit3executescript """ & StringTrimRight(@ScriptFullPath, 3) & "au3"" CheckForUpdates")
Else
Hotkeys(0)
MSGBox(16, "Check for Updates", "Cannot load update checker.")
Hotkeys(1)
EndIf
case else
for $i = 0 to ubound($trayids)-1
if $trayids[$i] = @tray_id then
$item = $i
exitLoop
endIf
next
showHideWin(hwnd($windows[$item]), $item)
endSelect
endFunc
func transparent()
hotkeys(0)
WinSetTrans("[active]", "", 0)
beep(1760, 50)
hotkeys(1)
endFunc
func unTransparent()
hotkeys(0)
WinSetTrans("[active]", "", 255)
beep(1760, 50)
sleep(50)
beep(1760, 50)
hotkeys(1)
endFunc
Func FindFirstAvailableSlot($startpos)
$aval = -1
for $i = $startpos to UBound($windows)-1
if HWND($Windows[$i]) = "0x00000000" Then
$aval = $i
ExitLoop
EndIf
Next
if $aval = -1 Then
SetError(1)
Return -1
EndIf
Return $aval
EndFunc
Func HideInFirst()
hotkeys(0)
$Num = FindFirstAvailableSlot($Shift)
if $num = -1 then
redim $windows[ubound($windows)+1]
$num = ubound($windows)-1
endIf
if $num > -1 and $num <= uBound($Windows)-1 then
showHideWin(WinGetHandle("[active]"), $num)
endIf
hotkeys(1)
EndFunc
func gui()
hotkeys(0)
dim $treeids[ubound($windows)]
$highestStack = ceiling(ubound($windows)/10)
dim $treeStackIds[$highestStack]
guiCreate("NUtils - "&_t("UnhideTitle"), 270, 530)
GUICtrlCreateLabel(_t("UnhideMessage"), 40, 30, 230, 40)
$tree = GuiCtrlCreateTreeView(30, 90, 220, 330)
$btnUnhide = GuiCtrlCreateButton(_t("UnhideButton"), 30, 470, 90, 40, 0x01)
$btnCancel = GuiCtrlCreateButton(_t("Cancel"), 160, 470, 90, 40)
$fullStacks = 0
for $i = 0 to ubound($treeStackIds)-1
if not isStackEmpty($i) then
$treeStackIds[$i] = GuiCtrlCreateTreeViewItem(_t("Stack") & " " & $i+1, $tree)
$fullStacks += 1
endIf
next
for $i = 0 to ubound($windows)-1
if hwnd($windows[$i]) <> "0x00000000" then
$stack = $treeStackIds[floor($i/10)]
$s=floor($i/10)+1&"."&Slot2Human(mod($i,10))&": "&winGetTitle(hwnd($windows[$i]))
$treeids[$i] = GuiCtrlCreateTreeViewItem($s, $stack)
endIf ;valid window
next
if $fullStacks = 0 then
guiCtrlSetState($btnUnhide, $GUI_DISABLE)
endIf
guiSetState()
;find the last item in history
$h = -1
for $i = ubound($hiddenwindows)-1 to 0 step -1
;=0 because 0 <> "x" returns false for some reason
if string($hiddenwindows[$i]) <> "x" then
If $hiddenwindows[$i] <= UBound($Treeids)-1 Then $h = $treeIds[$hiddenwindows[$i]]
exitLoop
endIf
next
if $h <> -1 then
GuiCtrlSetState($h, $GUI_FOCUS)
endIf
While 1
$msg = GUIGetMsg()
If not $msg Then ContinueLoop
Select
Case $msg = $GUI_EVENT_CLOSE
guiDelete()
hotkeys(1)
exitLoop
Case $msg = $btnCancel
guiDelete()
hotkeys(1)
exitLoop
case $msg = $btnUnhide
$selected = guiCtrlRead($tree)
for $i = 0 to ubound($treeIds)-1
if $treeIds[$i] = $selected then
guiDelete()
showHideWin($windows[$i], $i)
hotkeys(1)
return
endIf
next
;no item, probably a stack
for $i = 0 to ubound($treeStackIds)-1
if $treeStackIds[$i] <> $selected then
continueLoop
endIf
$start = $i*10
$end = min(($i*10)+9, ubound($windows)-1)
for $j = $start to $end
if hwnd($windows[$j]) <> "0x00000000" then
ShowHideWin($windows[$j], $j)
endIf ;valid?
next
next
Hotkeys(1)
guiDelete()
endSelect
wend
hotkeys(1)
endFunc
Func HistoryClean()
local $NewArray[1]
$NewArray[0] = "x"
for $i = 0 to UBound($HiddenWindows)-1
if $HiddenWindows[$i] <> "x" Then
$NewArray[UBound($NewArray)-1] = $HiddenWindows[$i]
Redim $NewArray[UBound($NewArray)+1]
EndIf
Next
ReDim $HiddenWindows[UBound($NewArray)]
for $i = 0 to UBound($NewArray)-1
$HiddenWindows[$i] = $NewArray[$i]
Next
EndFunc
func HistoryAdd($num)
reDim $hiddenwindows[uBound($hiddenwindows)+1]
$hiddenWindows[uBound($hiddenwindows)-1] = $num
endFunc
func HistoryDel($num)
for $i = 0 to ubound($hiddenwindows)-1
if $hiddenwindows[$i] = $num then
$hiddenwindows[$i] = "x"
endIf
next
endFunc
func hotkeys($x)
if $x = 1 then
HotKeySet($hk_edit, "EditScript")
HotKeySet($hk_reload, "reload")
HotKeySet($hk_solid, "unTransparent")
HotKeySet($hk_transparent, "transparent")
HotKeySet($hk_firstavailhide, "HideInFirst")
HotKeySet($hk_winls, "gui")
for $i = 0 to 9
HotKeySet($hk_bass & $i, "WinShowHide")
Next
for $i = 0 to 5
HotKeySet($hk_bass & "{f" & ($i+3) & "}", "SetPriority")
Next
HotKeySet($hk_winkill, "main")
HotKeySet($hk_chtitle, "main")
hotKeySet($hk_stackup, "shiftUp")
hotkeySet($hk_stackdown, "shiftDown")
else
HotKeySet($hk_edit, "dummy")
HotKeySet($hk_reload, "dummy")
HotKeySet($hk_solid, "dummy")
HotKeySet($hk_transparent, "dummy")
HotKeySet($hk_firstavailhide, "dummy")
HotKeySet($hk_winls, "dummy")
for $i = 0 to 9
HotKeySet($hk_bass & $i, "dummy")
Next
for $i = 0 to 5
HotKeySet($hk_bass & "{f" & $i+3 & "}", "Dummy")
Next
HotKeySet($hk_winkill, "dummy")
HotKeySet($hk_chtitle, "dummy")
hotKeySet($hk_stackup, "dummy")
hotkeySet($hk_stackdown, "dummy")
endIf
endFunc
func IsStackEmpty($stack)
$from = $stack*10
$to = $from+9
;if there aren't enough elements, it's empty
if ubound($windows)-1 < $from then
return 1
endIf
if $to > ubound($windows)-1 then
$to = ubound($windows)-1
endIf
for $i = $from to $to
if hwnd($windows[$i]) <> "0x00000000" Then
return 0
endIf
next
return 1
endFunc
func dummy()
endFunc
Func StackNotify()
If $StackCounter = 1 Then
if fileExists("Sounds\stack.wav") then
for $i = 1 to $shift/10+1
Soundplay("sounds\stack.wav", 1)
next
Else
for $i = 1 to $shift/10+1
Beep(2000, 60)
Sleep(50)
next
EndIf
Else
If Not PlayNum($Shift/10+1) Then
if fileExists("Sounds\stack.wav") then
for $i = 1 to $shift/10+1
Soundplay("sounds\stack.wav", 1)
next
Else
for $i = 1 to $shift/10+1
Beep(2000, 60)
Sleep(50)
next
EndIf
EndIf
EndIf
EndFunc
Func PlayNum($Num)
$n = StringSplit($Num, "")
if @Error Then
SetError(1)
Return
EndIf
$played = 1
for $i = 1 to $n[0]
If Not FileExists("Sounds\nums\" & $n[$i] & ".wav") Then
$Played = 0
ExitLoop
EndIf
Next
If $Played Then
for $i = 1 to $n[0]
Soundplay("sounds\nums\" & $n[$i] & ".wav", 1)
Next
Return 1
Else
SetError(2)
Return
EndIf
EndFunc
func _t($msg)
$out = INIRead("lang\" & $lang & ".ini", "str", $msg, "")
if $out = "" Then $out = INIRead("lang\en.ini", "str", $msg, "Lang_Output_Error")
$re = StringRegExp($out, "%([a-zA-Z0-9]+)%", 1)
if not @Error Then
for $i = 0 to UBound($re)-1
$out = StringReplace($out, "%" & $re[$i] & "%", _t($re[$i]))
Next
EndIf
Return $out
EndFunc
Func SetPriority()
Hotkeys(0)
$num = int(stringMid(@hotKeyPressed, StringLen($hk_bass)+3, 1))-3
If ProcessSetPriority(WinGetProcess("[active]"), $num) Then
If FileExists("Sounds\ProcessPrioritySounds\"&$num&".wav") Then
Soundplay("sounds\ProcessPrioritySounds\"&$Num&".wav")
Else
Beep(Round(440*(2^(($num*2)/12))), 60)
EndIf
Else
If FileExists("Sounds\ProcessPrioritySounds\er.wav") Then
Soundplay("sounds\ProcessPrioritySounds\er.wav")
Else
Beep(80, 130)
EndIf
EndIf
Hotkeys(1)
EndFunc

Func CheckForUpdates($quiet)
$ver = _INetgetSource($Info_Website & "/nutils.ver")
if @Error Then
if not $quiet then
MSGBox(16, _t("CheckForUpdates"), _t("CannotConnectTo") & " " & $Info_Website & ".")
EndIf
Else
$ver = StringStripWs($ver, 8)
if String($info_version) <> String($ver) Then
$choice = MSGBox(36, _t("CheckForUpdates"), _t("YouAreRunningNUtils") & " " & $Info_version & ". " & _t("TheCurrentVersionOfNUtilsIs") & " " & $ver &". " & _t("WouldYouLikeToVisitTheWebsiteNow"))
If $choice = 6 Then
InetGet($info_website & "/downloads/files/NUtils_Setup.exe", @TempDir & "\NUtils_Setup.exe", 1)
if not @error then
ShellExecute(@Tempdir & "\NUtils_Setup.exe")
EndIf
EndIf
Else
if not $quiet Then
MSGBox(64, _t("CheckForUpdates"), _t("YouAreRunningTheCurrentVersionOfNUtils") & " (" & $ver & ").")
EndIf
EndIf
EndIf
EndFunc
Func GetLangs()
local $w = @WorkingDir
FileChangeDir(@ScriptDir & "\lang")
if @Error Then
SetError(1)
Return
EndIf
local $file = FileFindFirstFile("*.ini")
local $ar[1][4]
local $Search
local $ln
local $Display
local $Native
local $Author
local $Sub
While 1
$Search = FileFindNextFile($File)
if @Error Then ExitLoop
$ln = StringTrimRight($Search, 4)
$Display = INIRead($Search, "Info", "Display", "")
if $Display = "" Then ContinueLoop
$Native = INIRead($Search, "Info", "Native", "")
if $Native = "" Then ContinueLoop
$Author = INIRead($Search, "Info", "Author", "")
if $Author = "" Then ContinueLoop
$sub = UBound($ar)
redim $ar[$sub+1][4]
$ar[$sub][0] = $ln
$ar[$sub][1] = $Display
$ar[$sub][2] = $Native
$ar[$sub][3] = $Author
Wend
FileChangeDir($w)
$ar[0][0] = UBound($ar)-1
Return $Ar
EndFunc
Func SelectLanguage()
Hotkeys(0)
GUICreate(_t("SelectLanguage"), 400, 600)
local $list = GUICtrlCreateListView(_t("Language") & "                       |" & _t("Author"), 30, 30, 340, 300)
local $btnselect = GUICtrlCreateButton(_t("SelectLanguage"), 30, 330, 90, 40, 0x01)
local $btncancel = GUICtrlCreateButton(_t("Cancel"), 280, 330, 90, 40)
local $lng = GetLangs()
local $ids[$lng[0][0]+1]
for $i = 1 to $lng[0][0]
$ids[$i] = GUICtrlCreateListViewItem($lng[$i][2] & " (" & $lng[$i][1] & ")|" & $lng[$i][3], $list)
Next
GUISetState()
While 1
local $msg = GUIGetMSG()
If $msg = $GUI_Event_Close or $msg = $btncancel Then
ExitLoop
ElseIf $msg = $btnSelect Then
$id = GUICtrlRead($List)
local $choice = 0
for $i = 1 to $lng[0][0]
if $ID = $ids[$i] Then
$Choice = $i
ExitLoop
EndIf
Next
If $Choice > 0 Then
Global $lang = $lng[$choice][0]
INIWrite("settings.ini", "settings", "Language", $lang)
UpdateTrayItems()
ExitLoop
EndIf
EndIf
Wend
GUIDelete()
Hotkeys(0)
EndFunc
func updateTrayItems ()
TrayItemSetText($tid_exit, _t("Exiticon"))
trayItemSetText($tid_lng, _t("SelectLanguage") & " (Select Language)...")
trayItemSetText($tid_checkforupdates, _t("CheckForUpdates")&"...")
trayItemSetText($tid_about, _t("About")&"...")
endFunc