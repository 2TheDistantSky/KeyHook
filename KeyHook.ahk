#SingleInstance force

; If the script is not elevated, relaunch as administrator and kill current instance:
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

Menu, Tray, Icon,,, 1

SetStoreCapslockMode, Off

global CLversion:="Version: 3.2.0.0 | 2020-10-24`n`nCopyright Junkai Chen"

global cClipboardAll ;capslock+ clipboard
global caClipboardAll ;capslock+alt clipboard
global sClipboardAll ;system clipboard
global whichClipboardNow ;0 system clipboard; 1 capslock+ clipboard; 2 capslock+alt clipboard
;  global clipSaveArr=[]
allowRunOnClipboardChange:=true

#Include lib
#Include lib_init.ahk ;The beginning of all things

; language
#include ..\language\lang_func.ahk
#include ..\language\English.ahk

#include lib_keysFunction.ahk
#include lib_keysSet.ahk
;get the settings from settings.ini
#include lib_settings.ahk
;capslock+Q
#Include lib_clQ.ahk
;capslock+T translate
#Include lib_ydTrans.ahk
;public functions
#Include lib_functions.ahk
;capslock+` 1~8, windows bind
#Include lib_bindWins.ahk
#Include lib_winJump.ahk
#Include lib_winTransparent.ahk

#MaxHotkeysPerInterval 500
#NoEnv
;  #WinActivateForce
Process Priority,,High

start:
    ; Triggered: 此次按键事件是否触发了修改后的热键
    global Triggered
    global LeaderPressed

$Space::
    Triggered:=0
    ; LeaderPressed: Space 键状态标记，按下是1，松开是0
    LeaderPressed:=1

    SetTimer, setTriggered, -300 ; 300ms 犹豫操作时间

    KeyWait, Space
    ; LeaderPressed 优先置空，关闭功能的触发
    LeaderPressed:=0
    if !Triggered
    {
        try
        runFunc(keyset.press_space)
    }
    Triggered:=1

    if(winTapedX!=-1)
    {
        winsSort(winTapedX)
    }

Return

setTriggered:
    Triggered:=1
return

; 剪贴板内容改变时将运行
OnClipboardChange:

    ; 如果有复制操作时，capslock键没有按下，那就是系统原生复制
    if (allowRunOnClipboardChange && !LeaderPressed && CLsets.global.allowClipboard != "0")
    {
        try {
            clipSaver("s")
        } catch _ {
            sleep 100
            clipSaver("s")
        }
        whichClipboardNow:=0
    }
    allowRunOnClipboardChange:=true
return

;----------------------------keys-set-start-----------------------------
#if CLsets.global.allowClipboard != "0"
$^v::
try
keyFunc_pasteSystem()
return
#if

#If LeaderPressed ;when leader key press and hold

LAlt::return

<!WheelUp::
    try
    runFunc(keyset.leader_lalt_wheelUp)
    Triggered:=1
return

<!WheelDown::
    try
    runFunc(keyset.leader_lalt_wheelDown)
    Triggered:=1
return

;--::-------------------------
;  KEY_TO_NAME := {"a":"a","b":"b","c":"c","d":"d","e":"e","f":"f","g":"g","h":"h","i":"i"
;    ,"j":"j","k":"k","l":"l","m":"m","n":"n","o":"o","p":"p","q":"q","r":"r"
;    ,"s":"s","t":"t","u":"u","v":"v","w":"w","x":"x","y":"y","z":"z"
;    ,"1":"1","2":"2","3":"3","4":"4","5":"5","6":"6","7":"7","8":"8","9":"9","0":"0"
;    ,"f1":"f1","f2":"f2","f3":"f3","f4":"f4","f5":"f5","f6":"f6"
;    ,"f7":"f7","f8":"f8","f9":"f9","f10":"f10","f11":"f11","f12":"f12"
;    ,"f13":"f13","f14":"f14","f15":"f15","f16":"f16","f17":"f17","f18":"f18","f19":"f19"
;    ,"space":"space","tab":"tab","enter":"enter","esc":"esc","backspace":"backspace"
;    ,"`":"backQuote","-":"minus","=":"equal","[":"leftSquareBracket","]":"rightSquareBracket"
;    ,"\":"backSlash",";":"semicolon","'":"quote",",":"comma",".":"dot","/":"slash","ralt":"ralt"
;    ,"wheelUp":"wheelUp","wheelDown":"wheelDown"}

;  for k,v in KEY_TO_NAME{
;      msgbox, % v
;  }
a::
b::
c::
d::
e::
f::
g::
h::
i::
j::
k::
l::
n::
m::
o::
p::
q::
r::
s::
t::
u::
v::
w::
x::
y::
z::
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
f1::
f2::
f3::
f4::
f5::
f6::
f7::
f8::
f9::
f10::
f11::
f12::
space::
tab::
enter::
esc::
backspace::
ralt::
    try
    runFunc(keyset["leader_" . A_ThisHotkey])
    Triggered:=1
Return

`::
    try
    runFunc(keyset.leader_backQuote)
    Triggered:=1
return

-::
    try
    runFunc(keyset.leader_minus)
    Triggered:=1
return

=::
    try
    runFunc(keyset.leader_equal)
    Triggered:=1
Return

[::
    try
    runFunc(keyset.leader_leftSquareBracket)
    Triggered:=1
Return

]::
    try
    runFunc(keyset.leader_rightSquareBracket)
    Triggered:=1
Return

\::
    try
    runFunc(keyset.leader_backslash)
    Triggered:=1
return

`;::
try
runFunc(keyset.leader_semicolon)
Triggered:=1
Return

'::
    try
    runFunc(keyset.leader_quote)
    Triggered:=1
return

,::
    try
    runFunc(keyset.leader_comma)
    Triggered:=1
Return

.::
    try
    runFunc(keyset.leader_dot)
    Triggered:=1
return

/::
    try
    runFunc(keyset.leader_slash)
    Triggered:=1
Return

;  RAlt::
;  try
;      runFunc(keyset.leader_ralt)
;  Triggered:=1
;  return

;---------------------caps+lalt----------------

<!a::
    try
    runFunc(keyset.leader_lalt_a)
    Triggered:=1
return

<!b::
    try
    runFunc(keyset.leader_lalt_b)
    Triggered:=1
Return

<!c::
    try
    runFunc(keyset.leader_lalt_c)
    Triggered:=1
return

<!d::
    try
    runFunc(keyset.leader_lalt_d)
    Triggered:=1
Return

<!e::
    try
    runFunc(keyset.leader_lalt_e)
    Triggered:=1
Return

<!f::
    try
    runFunc(keyset.leader_lalt_f)
    Triggered:=1
Return

<!g::
    try
    runFunc(keyset.leader_lalt_g)
    Triggered:=1
Return

<!h::
    try
    runFunc(keyset.leader_lalt_h)
    Triggered:=1
return

<!i::
    try
    runFunc(keyset.leader_lalt_i)
    Triggered:=1
return

<!j::
    try
    runFunc(keyset.leader_lalt_j)
    Triggered:=1
return

<!k::
    try
    runFunc(keyset.leader_lalt_k)
    Triggered:=1
return

<!l::
    try
    runFunc(keyset.leader_lalt_l)
    Triggered:=1
return

<!m::
    try
    runFunc(keyset.leader_lalt_m)
    Triggered:=1
return

<!n::
    try
    runFunc(keyset.leader_lalt_n)
    Triggered:=1
Return

<!o::
    try
    runFunc(keyset.leader_lalt_o)
    Triggered:=1
return

<!p::
    try
    runFunc(keyset.leader_lalt_p)
    Triggered:=1
Return

<!q::
    try
    runFunc(keyset.leader_lalt_q)
    Triggered:=1
return

<!r::
    try
    runFunc(keyset.leader_lalt_r)
    Triggered:=1
Return

<!s::
    try
    runFunc(keyset.leader_lalt_s)
    Triggered:=1
Return

<!t::
    try
    runFunc(keyset.leader_lalt_t)
    Triggered:=1
Return

<!u::
    try
    runFunc(keyset.leader_lalt_u)
    Triggered:=1
return

<!v::
    try
    runFunc(keyset.leader_lalt_v)
    Triggered:=1
Return

<!w::
    try
    runFunc(keyset.leader_lalt_w)
    Triggered:=1
Return

<!x::
    try
    runFunc(keyset.leader_lalt_x)
    Triggered:=1
Return

<!y::
    try
    runFunc(keyset.leader_lalt_y)
    Triggered:=1
return

<!z::
    try
    runFunc(keyset.leader_lalt_z)
    Triggered:=1
Return

<!`::
    runFunc(keyset.leader_lalt_backquote)
    Triggered:=1
return

<!1::
    try
    runFunc(keyset.leader_lalt_1)
    Triggered:=1
return

<!2::
    try
    runFunc(keyset.leader_lalt_2)
    Triggered:=1
return

<!3::
    try
    runFunc(keyset.leader_lalt_3)
    Triggered:=1
return

<!4::
    try
    runFunc(keyset.leader_lalt_4)
    Triggered:=1
return

<!5::
    try
    runFunc(keyset.leader_lalt_5)
    Triggered:=1
return

<!6::
    try
    runFunc(keyset.leader_lalt_6)
    Triggered:=1
return

<!7::
    try
    runFunc(keyset.leader_lalt_7)
    Triggered:=1
return

<!8::
    try
    runFunc(keyset.leader_lalt_8)
    Triggered:=1
return

<!9::
    try
    runFunc(keyset.leader_lalt_9)
    Triggered:=1
Return

<!0::
    try
    runFunc(keyset.leader_lalt_0)
    Triggered:=1
Return

<!-::
    try
    runFunc(keyset.leader_lalt_minus)
    Triggered:=1
return

<!=::
    try
    runFunc(keyset.leader_lalt_equal)
    Triggered:=1
Return

<!BackSpace::
    try
    runFunc(keyset.leader_lalt_backspace)
    Triggered:=1
Return

<!Tab::
    try
    runFunc(keyset.leader_lalt_tab)
    Triggered:=1
Return

<![::
    try
    runFunc(keyset.leader_lalt_leftSquareBracket)
    Triggered:=1
Return

<!]::
    try
    runFunc(keyset.leader_lalt_rightSquareBracket)
    Triggered:=1
Return

<!\::
    try
    runFunc(keyset.leader_lalt_Backslash)
    Triggered:=1
return

<!`;::
try
runFunc(keyset.leader_lalt_semicolon)
Triggered:=1
Return

<!'::
    try
    runFunc(keyset.leader_lalt_quote)
    Triggered:=1
return

<!Enter::
    try
    runFunc(keyset.leader_lalt_enter)
    Triggered:=1
Return

<!,::
    try
    runFunc(keyset.leader_lalt_comma)
    Triggered:=1
Return

<!.::
    try
    runFunc(keyset.leader_lalt_dot)
    Triggered:=1
return

<!/::
    try
    runFunc(keyset.leader_lalt_slash)
    Triggered:=1
Return

<!Space::
    try
    runFunc(keyset.leader_lalt_space)
    Triggered:=1
Return

<!RAlt::
    try
    runFunc(keyset.leader_lalt_ralt)
    Triggered:=1
return

<!F1::
    try
    runFunc(keyset.leader_lalt_f1)
    Triggered:=1
return

<!F2::
    try
    runFunc(keyset.leader_lalt_f2)
    Triggered:=1
return

<!F3::
    try
    runFunc(keyset.leader_lalt_f3)
    Triggered:=1
return

<!F4::
    try
    runFunc(keyset.leader_lalt_f4)
    Triggered:=1
return

<!F5::
    try
    runFunc(keyset.leader_lalt_f5)
    Triggered:=1
return

<!F6::
    try
    runFunc(keyset.leader_lalt_f6)
    Triggered:=1
return

<!F7::
    try
    runFunc(keyset.leader_lalt_f7)
    Triggered:=1
return

<!F8::
    try
    runFunc(keyset.leader_lalt_f8)
    Triggered:=1
return

<!F9::
    try
    runFunc(keyset.leader_lalt_f9)
    Triggered:=1
return

<!F10::
    try
    runFunc(keyset.leader_lalt_f10)
    Triggered:=1
return

<!F11::
    try
    runFunc(keyset.leader_lalt_f11)
    Triggered:=1
return

<!F12::
    try
    runFunc(keyset.leader_lalt_f12)
    Triggered:=1
return

#1::
    try
    runFunc(keyset.leader_win_1)
    Triggered:=1
return

#2::
    try
    runFunc(keyset.leader_win_2)
    Triggered:=1
return

#3::
    try
    runFunc(keyset.leader_win_3)
    Triggered:=1
return

#4::
    try
    runFunc(keyset.leader_win_4)
    Triggered:=1
return

#5::
    try
    runFunc(keyset.leader_win_5)
    Triggered:=1
return

#6::
    try
    runFunc(keyset.leader_win_6)
    Triggered:=1
return

#7::
    try
    runFunc(keyset.leader_win_7)
    Triggered:=1
return

#8::
    try
    runFunc(keyset.leader_win_8)
    Triggered:=1
return

#9::
    try
    runFunc(keyset.leader_win_9)
    Triggered:=1
return

#0::
    try
    runFunc(keyset.leader_win_0)
    Triggered:=1
return
;  #s::
;      keyFunc_activateSideWin("l")
;  Triggered:=1
;  return

;  #f::
;      keyFunc_activateSideWin("r")
;      Triggered:=1
;  return

;  #e::
;      keyFunc_activateSideWin("u")
;  Triggered:=1
;  return

;  #d::
;      keyFunc_activateSideWin("d")
;      Triggered:=1
;  return

;  #w::
;      keyFunc_putWinToBottom()
;      Triggered:=1
;  return

;  #a::
;      keyFunc_activateSideWin("fl")
;      Triggered:=1
;  return

;  #g::
;      keyFunc_activateSideWin("fr")
;      Triggered:=1
;  return

;  #z::
;      keyFunc_clearWinMinimizeStach()
;      Triggered:=1
;  return

;  #x::
;      keyFunc_inWinMinimizeStack(true)
;      Triggered:=1
;  return

;  #c::
;      keyFunc_inWinMinimizeStack()
;      Triggered:=1
;  return

;  #v::
;      keyFunc_outWinMinimizeStack()
;      Triggered:=1
;  return

#If

GuiClose:
GuiEscape:
    Gui, Cancel
return
