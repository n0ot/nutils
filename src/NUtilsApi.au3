#include-once
#include <sendmessage.au3>
$nutilsAPIWindowName = "ArbalonNUtilsWND"
func _nutils_ShowHide($handle)
$wh = winGetHandle($nutilsAPIWindowName)
if not @error then
_sendMessage($wh, 0x0501, 0, $handle, 0)
endIf
endFunc