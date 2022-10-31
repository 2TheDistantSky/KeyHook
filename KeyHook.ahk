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
global whichClipboardNow  ;0 system clipboard; 1 capslock+ clipboard; 2 capslock+alt clipboard
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
#Include lib_mouseSpeed.ahk

#MaxHotkeysPerInterval 500
#NoEnv
;  #WinActivateForce
Process Priority,,High


start:

;-----------------START-----------------
global SpaceFlag, CapsLock

$Space::
;Capslock:  Capslock 键状态标记，按下是1，松开是0
;SpaceFlag: 是否使用过 Capslock+ 功能标记，使用过会清除这个变量
SpaceFlag:=CapsLock:=1

SetTimer, setSpaceFlag, -300 ; 300ms 犹豫操作时间

settimer, changeMouseSpeed, 50 ;暂时修改鼠标速度

KeyWait, Space
CapsLock:="" ;Capslock最优先置空，来关闭 Capslock+ 功能的触发
if SpaceFlag
{
    if keyset.press_space
    {
        try
            runFunc(keyset.press_space)
    }
}
SpaceFlag:=""

;
if(winTapedX!=-1)
{
    winsSort(winTapedX)
}

Return

setSpaceFlag:
SpaceFlag:=""
return

OnClipboardChange:  ; 剪贴板内容改变时将运行

; 如果有复制操作时，capslock键没有按下，那就是系统原生复制
if (allowRunOnClipboardChange && !CapsLock && CLsets.global.allowClipboard != "0")
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

#If CapsLock ;when capslock key press and hold

LAlt::return

<!WheelUp::
try
    runFunc(keyset.space_lalt_wheelUp)
SpaceFlag:=""
return

<!WheelDown::
try
    runFunc(keyset.space_lalt_wheelDown)
SpaceFlag:=""
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
SpaceFlag:=""
Return

`::
try
    runFunc(keyset.space_backQuote)
SpaceFlag:=""
return


-::
try
    runFunc(keyset.space_minus)
SpaceFlag:=""
return

=::
try
    runFunc(keyset.space_equal)
SpaceFlag:=""
Return


[::
try
    runFunc(keyset.space_leftSquareBracket)
SpaceFlag:=""
Return

]::
try
    runFunc(keyset.space_rightSquareBracket)
SpaceFlag:=""
Return

\::
try
    runFunc(keyset.space_backslash)
SpaceFlag:=""
return

`;::
try
    runFunc(keyset.space_semicolon)
SpaceFlag:=""
Return

'::
try
    runFunc(keyset.space_quote)
SpaceFlag:=""
return


,::
try
    runFunc(keyset.space_comma)
SpaceFlag:=""
Return

.::
try
    runFunc(keyset.space_dot)
SpaceFlag:=""
return

/::
try
    runFunc(keyset.space_slash)
SpaceFlag:=""
Return

;  RAlt::
;  try
;      runFunc(keyset.space_ralt)
;  SpaceFlag:=""
;  return



;---------------------caps+lalt----------------

<!a::
try
    runFunc(keyset.space_lalt_a)
SpaceFlag:=""
return

<!b::
try
    runFunc(keyset.space_lalt_b)
SpaceFlag:=""
Return

<!c::
try
    runFunc(keyset.space_lalt_c)
SpaceFlag:=""
return

<!d::
try
    runFunc(keyset.space_lalt_d)
SpaceFlag:=""
Return

<!e::
try
    runFunc(keyset.space_lalt_e)
SpaceFlag:=""
Return

<!f::
try
    runFunc(keyset.space_lalt_f)
SpaceFlag:=""
Return

<!g::
try
    runFunc(keyset.space_lalt_g)
SpaceFlag:=""
Return

<!h::
try
    runFunc(keyset.space_lalt_h)
SpaceFlag:=""
return

<!i::
try
    runFunc(keyset.space_lalt_i)
SpaceFlag:=""
return

<!j::
try
    runFunc(keyset.space_lalt_j)
SpaceFlag:=""
return

<!k::
try
    runFunc(keyset.space_lalt_k)
SpaceFlag:=""
return

<!l::
try
    runFunc(keyset.space_lalt_l)
SpaceFlag:=""
return

<!m::
try
    runFunc(keyset.space_lalt_m)
SpaceFlag:=""
return

<!n::
try
    runFunc(keyset.space_lalt_n)
SpaceFlag:=""
Return

<!o::
try
    runFunc(keyset.space_lalt_o)
SpaceFlag:=""
return

<!p::
try
    runFunc(keyset.space_lalt_p)
SpaceFlag:=""
Return

<!q::
try
    runFunc(keyset.space_lalt_q)
SpaceFlag:=""
return

<!r::
try
    runFunc(keyset.space_lalt_r)
SpaceFlag:=""
Return

<!s::
try
    runFunc(keyset.space_lalt_s)
SpaceFlag:=""
Return

<!t::
try
    runFunc(keyset.space_lalt_t)
SpaceFlag:=""
Return

<!u::
try
    runFunc(keyset.space_lalt_u)
SpaceFlag:=""
return

<!v::
try
    runFunc(keyset.space_lalt_v)
SpaceFlag:=""
Return

<!w::
try
    runFunc(keyset.space_lalt_w)
SpaceFlag:=""
Return

<!x::
try
    runFunc(keyset.space_lalt_x)
SpaceFlag:=""
Return

<!y::
try
    runFunc(keyset.space_lalt_y)
SpaceFlag:=""
return

<!z::
try
    runFunc(keyset.space_lalt_z)
SpaceFlag:=""
Return

<!`::
    runFunc(keyset.space_lalt_backquote)
SpaceFlag:=""
return

<!1::
try
    runFunc(keyset.space_lalt_1)
SpaceFlag:=""
return

<!2::
try
    runFunc(keyset.space_lalt_2)
SpaceFlag:=""
return

<!3::
try
    runFunc(keyset.space_lalt_3)
SpaceFlag:=""
return

<!4::
try
    runFunc(keyset.space_lalt_4)
SpaceFlag:=""
return

<!5::
try
    runFunc(keyset.space_lalt_5)
SpaceFlag:=""
return

<!6::
try
    runFunc(keyset.space_lalt_6)
SpaceFlag:=""
return

<!7::
try
    runFunc(keyset.space_lalt_7)
SpaceFlag:=""
return

<!8::
try
    runFunc(keyset.space_lalt_8)
SpaceFlag:=""
return

<!9::
try
    runFunc(keyset.space_lalt_9)
SpaceFlag:=""
Return

<!0::
try
    runFunc(keyset.space_lalt_0)
SpaceFlag:=""
Return

<!-::
try
    runFunc(keyset.space_lalt_minus)
SpaceFlag:=""
return

<!=::
try
    runFunc(keyset.space_lalt_equal)
SpaceFlag:=""
Return

<!BackSpace::
try
    runFunc(keyset.space_lalt_backspace)
SpaceFlag:=""
Return

<!Tab::
try
    runFunc(keyset.space_lalt_tab)
SpaceFlag:=""
Return

<![::
try
    runFunc(keyset.space_lalt_leftSquareBracket)
SpaceFlag:=""
Return

<!]::
try
    runFunc(keyset.space_lalt_rightSquareBracket)
SpaceFlag:=""
Return

<!\::
try
    runFunc(keyset.space_lalt_Backslash)
SpaceFlag:=""
return

<!`;::
try
    runFunc(keyset.space_lalt_semicolon)
SpaceFlag:=""
Return

<!'::
try
    runFunc(keyset.space_lalt_quote)
SpaceFlag:=""
return

<!Enter::
try
    runFunc(keyset.space_lalt_enter)
SpaceFlag:=""
Return

<!,::
try
    runFunc(keyset.space_lalt_comma)
SpaceFlag:=""
Return

<!.::
try
    runFunc(keyset.space_lalt_dot)
SpaceFlag:=""
return

<!/::
try
    runFunc(keyset.space_lalt_slash)
SpaceFlag:=""
Return

<!Space::
try
    runFunc(keyset.space_lalt_space)
SpaceFlag:=""
Return

<!RAlt::
try
    runFunc(keyset.space_lalt_ralt)
SpaceFlag:=""
return

<!F1::
try
    runFunc(keyset.space_lalt_f1)
SpaceFlag:=""
return

<!F2::
try
    runFunc(keyset.space_lalt_f2)
SpaceFlag:=""
return

<!F3::
try
    runFunc(keyset.space_lalt_f3)
SpaceFlag:=""
return

<!F4::
try
    runFunc(keyset.space_lalt_f4)
SpaceFlag:=""
return

<!F5::
try
    runFunc(keyset.space_lalt_f5)
SpaceFlag:=""
return

<!F6::
try
    runFunc(keyset.space_lalt_f6)
SpaceFlag:=""
return

<!F7::
try
    runFunc(keyset.space_lalt_f7)
SpaceFlag:=""
return

<!F8::
try
    runFunc(keyset.space_lalt_f8)
SpaceFlag:=""
return

<!F9::
try
    runFunc(keyset.space_lalt_f9)
SpaceFlag:=""
return

<!F10::
try
    runFunc(keyset.space_lalt_f10)
SpaceFlag:=""
return

<!F11::
try
    runFunc(keyset.space_lalt_f11)
SpaceFlag:=""
return

<!F12::
try
    runFunc(keyset.space_lalt_f12)
SpaceFlag:=""
return

#1::
try
    runFunc(keyset.space_win_1)
SpaceFlag:=""
return

#2::
try
    runFunc(keyset.space_win_2)
SpaceFlag:=""
return

#3::
try
    runFunc(keyset.space_win_3)
SpaceFlag:=""
return

#4::
try
    runFunc(keyset.space_win_4)
SpaceFlag:=""
return

#5::
try
    runFunc(keyset.space_win_5)
SpaceFlag:=""
return

#6::
try
    runFunc(keyset.space_win_6)
SpaceFlag:=""
return

#7::
try
    runFunc(keyset.space_win_7)
SpaceFlag:=""
return

#8::
try
    runFunc(keyset.space_win_8)
SpaceFlag:=""
return

#9::
try
    runFunc(keyset.space_win_9)
SpaceFlag:=""
return

#0::
try
    runFunc(keyset.space_win_0)
SpaceFlag:=""
return
;  #s::
;      keyFunc_activateSideWin("l")
;  SpaceFlag:=""
;  return

;  #f::
;      keyFunc_activateSideWin("r")
;      SpaceFlag:=""
;  return

;  #e::
;      keyFunc_activateSideWin("u")
;  SpaceFlag:=""
;  return

;  #d::
;      keyFunc_activateSideWin("d")
;      SpaceFlag:=""
;  return

;  #w::
;      keyFunc_putWinToBottom()
;      SpaceFlag:=""
;  return

;  #a::
;      keyFunc_activateSideWin("fl")
;      SpaceFlag:=""
;  return

;  #g::
;      keyFunc_activateSideWin("fr")
;      SpaceFlag:=""
;  return

;  #z::
;      keyFunc_clearWinMinimizeStach()
;      SpaceFlag:=""
;  return

;  #x::
;      keyFunc_inWinMinimizeStack(true)
;      SpaceFlag:=""
;  return

;  #c::
;      keyFunc_inWinMinimizeStack()
;      SpaceFlag:=""
;  return

;  #v::
;      keyFunc_outWinMinimizeStack()
;      SpaceFlag:=""
;  return



#If




GuiClose:
GuiEscape:
Gui, Cancel
return
