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
    global Triggered, SpacePressed

$Space::
    ; Triggered: 是否使用过 Capslock+ 功能标记，使用过会清除这个变量
    ; SpacePressed: Space 键状态标记，按下是1，松开是0
    Triggered:=SpacePressed:=1

    SetTimer, setTriggered, -300 ; 300ms 犹豫操作时间

    KeyWait, Space
    ; SpacePressed 优先置空，关闭功能的触发
    SpacePressed:=""
    if Triggered
    {
        try
        runFunc(keyset.press_space)
    }
    Triggered:=""

    if(winTapedX!=-1)
    {
        winsSort(winTapedX)
    }

Return

setTriggered:
    Triggered:=""
return

OnClipboardChange: ; 剪贴板内容改变时将运行

    ; 如果有复制操作时，capslock键没有按下，那就是系统原生复制
    if (allowRunOnClipboardChange && !SpacePressed && CLsets.global.allowClipboard != "0")
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

#If SpacePressed ;when capslock key press and hold

LAlt::return

<!WheelUp::
    try
    runFunc(keyset.space_lalt_wheelUp)
    Triggered:=""
return

<!WheelDown::
    try
    runFunc(keyset.space_lalt_wheelDown)
    Triggered:=""
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
    runFunc(keyset["space_" . A_ThisHotkey])
    Triggered:=""
Return

`::
    try
    runFunc(keyset.space_backQuote)
    Triggered:=""
return

-::
    try
    runFunc(keyset.space_minus)
    Triggered:=""
return

=::
    try
    runFunc(keyset.space_equal)
    Triggered:=""
Return

[::
    try
    runFunc(keyset.space_leftSquareBracket)
    Triggered:=""
Return

]::
    try
    runFunc(keyset.space_rightSquareBracket)
    Triggered:=""
Return

\::
    try
    runFunc(keyset.space_backslash)
    Triggered:=""
return

`;::
try
runFunc(keyset.space_semicolon)
Triggered:=""
Return

'::
    try
    runFunc(keyset.space_quote)
    Triggered:=""
return

,::
    try
    runFunc(keyset.space_comma)
    Triggered:=""
Return

.::
    try
    runFunc(keyset.space_dot)
    Triggered:=""
return

/::
    try
    runFunc(keyset.space_slash)
    Triggered:=""
Return

;  RAlt::
;  try
;      runFunc(keyset.space_ralt)
;  Triggered:=""
;  return

;---------------------caps+lalt----------------

<!a::
    try
    runFunc(keyset.space_lalt_a)
    Triggered:=""
return

<!b::
    try
    runFunc(keyset.space_lalt_b)
    Triggered:=""
Return

<!c::
    try
    runFunc(keyset.space_lalt_c)
    Triggered:=""
return

<!d::
    try
    runFunc(keyset.space_lalt_d)
    Triggered:=""
Return

<!e::
    try
    runFunc(keyset.space_lalt_e)
    Triggered:=""
Return

<!f::
    try
    runFunc(keyset.space_lalt_f)
    Triggered:=""
Return

<!g::
    try
    runFunc(keyset.space_lalt_g)
    Triggered:=""
Return

<!h::
    try
    runFunc(keyset.space_lalt_h)
    Triggered:=""
return

<!i::
    try
    runFunc(keyset.space_lalt_i)
    Triggered:=""
return

<!j::
    try
    runFunc(keyset.space_lalt_j)
    Triggered:=""
return

<!k::
    try
    runFunc(keyset.space_lalt_k)
    Triggered:=""
return

<!l::
    try
    runFunc(keyset.space_lalt_l)
    Triggered:=""
return

<!m::
    try
    runFunc(keyset.space_lalt_m)
    Triggered:=""
return

<!n::
    try
    runFunc(keyset.space_lalt_n)
    Triggered:=""
Return

<!o::
    try
    runFunc(keyset.space_lalt_o)
    Triggered:=""
return

<!p::
    try
    runFunc(keyset.space_lalt_p)
    Triggered:=""
Return

<!q::
    try
    runFunc(keyset.space_lalt_q)
    Triggered:=""
return

<!r::
    try
    runFunc(keyset.space_lalt_r)
    Triggered:=""
Return

<!s::
    try
    runFunc(keyset.space_lalt_s)
    Triggered:=""
Return

<!t::
    try
    runFunc(keyset.space_lalt_t)
    Triggered:=""
Return

<!u::
    try
    runFunc(keyset.space_lalt_u)
    Triggered:=""
return

<!v::
    try
    runFunc(keyset.space_lalt_v)
    Triggered:=""
Return

<!w::
    try
    runFunc(keyset.space_lalt_w)
    Triggered:=""
Return

<!x::
    try
    runFunc(keyset.space_lalt_x)
    Triggered:=""
Return

<!y::
    try
    runFunc(keyset.space_lalt_y)
    Triggered:=""
return

<!z::
    try
    runFunc(keyset.space_lalt_z)
    Triggered:=""
Return

<!`::
    runFunc(keyset.space_lalt_backquote)
    Triggered:=""
return

<!1::
    try
    runFunc(keyset.space_lalt_1)
    Triggered:=""
return

<!2::
    try
    runFunc(keyset.space_lalt_2)
    Triggered:=""
return

<!3::
    try
    runFunc(keyset.space_lalt_3)
    Triggered:=""
return

<!4::
    try
    runFunc(keyset.space_lalt_4)
    Triggered:=""
return

<!5::
    try
    runFunc(keyset.space_lalt_5)
    Triggered:=""
return

<!6::
    try
    runFunc(keyset.space_lalt_6)
    Triggered:=""
return

<!7::
    try
    runFunc(keyset.space_lalt_7)
    Triggered:=""
return

<!8::
    try
    runFunc(keyset.space_lalt_8)
    Triggered:=""
return

<!9::
    try
    runFunc(keyset.space_lalt_9)
    Triggered:=""
Return

<!0::
    try
    runFunc(keyset.space_lalt_0)
    Triggered:=""
Return

<!-::
    try
    runFunc(keyset.space_lalt_minus)
    Triggered:=""
return

<!=::
    try
    runFunc(keyset.space_lalt_equal)
    Triggered:=""
Return

<!BackSpace::
    try
    runFunc(keyset.space_lalt_backspace)
    Triggered:=""
Return

<!Tab::
    try
    runFunc(keyset.space_lalt_tab)
    Triggered:=""
Return

<![::
    try
    runFunc(keyset.space_lalt_leftSquareBracket)
    Triggered:=""
Return

<!]::
    try
    runFunc(keyset.space_lalt_rightSquareBracket)
    Triggered:=""
Return

<!\::
    try
    runFunc(keyset.space_lalt_Backslash)
    Triggered:=""
return

<!`;::
try
runFunc(keyset.space_lalt_semicolon)
Triggered:=""
Return

<!'::
    try
    runFunc(keyset.space_lalt_quote)
    Triggered:=""
return

<!Enter::
    try
    runFunc(keyset.space_lalt_enter)
    Triggered:=""
Return

<!,::
    try
    runFunc(keyset.space_lalt_comma)
    Triggered:=""
Return

<!.::
    try
    runFunc(keyset.space_lalt_dot)
    Triggered:=""
return

<!/::
    try
    runFunc(keyset.space_lalt_slash)
    Triggered:=""
Return

<!Space::
    try
    runFunc(keyset.space_lalt_space)
    Triggered:=""
Return

<!RAlt::
    try
    runFunc(keyset.space_lalt_ralt)
    Triggered:=""
return

<!F1::
    try
    runFunc(keyset.space_lalt_f1)
    Triggered:=""
return

<!F2::
    try
    runFunc(keyset.space_lalt_f2)
    Triggered:=""
return

<!F3::
    try
    runFunc(keyset.space_lalt_f3)
    Triggered:=""
return

<!F4::
    try
    runFunc(keyset.space_lalt_f4)
    Triggered:=""
return

<!F5::
    try
    runFunc(keyset.space_lalt_f5)
    Triggered:=""
return

<!F6::
    try
    runFunc(keyset.space_lalt_f6)
    Triggered:=""
return

<!F7::
    try
    runFunc(keyset.space_lalt_f7)
    Triggered:=""
return

<!F8::
    try
    runFunc(keyset.space_lalt_f8)
    Triggered:=""
return

<!F9::
    try
    runFunc(keyset.space_lalt_f9)
    Triggered:=""
return

<!F10::
    try
    runFunc(keyset.space_lalt_f10)
    Triggered:=""
return

<!F11::
    try
    runFunc(keyset.space_lalt_f11)
    Triggered:=""
return

<!F12::
    try
    runFunc(keyset.space_lalt_f12)
    Triggered:=""
return

#1::
    try
    runFunc(keyset.space_win_1)
    Triggered:=""
return

#2::
    try
    runFunc(keyset.space_win_2)
    Triggered:=""
return

#3::
    try
    runFunc(keyset.space_win_3)
    Triggered:=""
return

#4::
    try
    runFunc(keyset.space_win_4)
    Triggered:=""
return

#5::
    try
    runFunc(keyset.space_win_5)
    Triggered:=""
return

#6::
    try
    runFunc(keyset.space_win_6)
    Triggered:=""
return

#7::
    try
    runFunc(keyset.space_win_7)
    Triggered:=""
return

#8::
    try
    runFunc(keyset.space_win_8)
    Triggered:=""
return

#9::
    try
    runFunc(keyset.space_win_9)
    Triggered:=""
return

#0::
    try
    runFunc(keyset.space_win_0)
    Triggered:=""
return
;  #s::
;      keyFunc_activateSideWin("l")
;  Triggered:=""
;  return

;  #f::
;      keyFunc_activateSideWin("r")
;      Triggered:=""
;  return

;  #e::
;      keyFunc_activateSideWin("u")
;  Triggered:=""
;  return

;  #d::
;      keyFunc_activateSideWin("d")
;      Triggered:=""
;  return

;  #w::
;      keyFunc_putWinToBottom()
;      Triggered:=""
;  return

;  #a::
;      keyFunc_activateSideWin("fl")
;      Triggered:=""
;  return

;  #g::
;      keyFunc_activateSideWin("fr")
;      Triggered:=""
;  return

;  #z::
;      keyFunc_clearWinMinimizeStach()
;      Triggered:=""
;  return

;  #x::
;      keyFunc_inWinMinimizeStack(true)
;      Triggered:=""
;  return

;  #c::
;      keyFunc_inWinMinimizeStack()
;      Triggered:=""
;  return

;  #v::
;      keyFunc_outWinMinimizeStack()
;      Triggered:=""
;  return

#If

GuiClose:
GuiEscape:
    Gui, Cancel
return
