#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Anime4000

 Script Function:
	Quickly login V2801F firmware to fix invalid VS_AUTH_KEY

	When VS_AUTH_KEY is invalid, V2801F will reboot, you have few seconds to
	access telnet, this script help you to quickly login and apply some fix

	Press F9 key to enter admin,
	Press F10 key to enter password,
	Press F11 key to block device from reboot, you need plug out fiber to access

	Press INSERT key to enter "flash set" value
	Press DELETE key to get "flash get" value

	Press DEL key to quit

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
HotKeySet("{END}", "ExitProgram")
HotKeySet("{F9}", "EnterAdmin")
HotKeySet("{F10}", "EnterPassword")
HotKeySet("{F11}", "EnterBlockReboot")
HotKeySet("{INS}", "EnterCommandSet")
HotKeySet("{DEL}", "EnterCommandGet")

While 1
   Sleep(1000)
WEnd

Func ExitProgram()
	Exit
EndFunc

Func EnterAdmin()
	Send("admin{ENTER}")
EndFunc

Func EnterPassword()
	Send("system{ENTER}")
EndFunc

Func EnterBlockReboot()
	Send("echo 3 > /proc/fiber_mode{ENTER}")
EndFunc

Func EnterCommandSet()
	Send("flash set HW_HWVER RTL960x{ENTER}")
	Send("flash set VS_AUTH_KEY C8F355A2986FD5AA69989A667AA90BB5{ENTER}")

	Send("flash set OMCI_FAKE_OK 1{ENTER}")
	Send("flash set OMCI_SW_VER1 C00R657V00B15{ENTER}")
	Send("flash set OMCI_SW_VER2 C00R657V00B15{ENTER}")
	Send("flash set GPON_SN GPONC60DDEAD{ENTER}")
	Send("flash set GPON_PLOAM_PASSWD 1234567890{ENTER}")
	Send("flash set ELAN_MAC_ADDR 6cefc60ddead{ENTER}")
EndFunc

Func EnterCommandGet()
	Send("flash get HW_HWVER{ENTER}")
	Send("flash get VS_AUTH_KEY{ENTER}")

	Send("flash get OMCI_FAKE_OK{ENTER}")
	Send("flash get OMCI_SW_VER1{ENTER}")
	Send("flash get OMCI_SW_VER2{ENTER}")
	Send("flash get GPON_SN{ENTER}")
	Send("flash get GPON_PLOAM_PASSWD{ENTER}")
	Send("flash get ELAN_MAC_ADDR{ENTER}")
EndFunc
