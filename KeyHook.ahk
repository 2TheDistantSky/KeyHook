#SingleInstance force
#MaxHotkeysPerInterval 500
#NoEnv
Process Priority,,High

#Include components
#Include init.ahk
#Include keys_function.ahk
#Include youdao_translate.ahk
#Include functions.ahk
#Include bind_wins.ahk
#Include win_jump.ahk

start:
    ; Triggered: 此次按键事件是否触发了修改后的热键
    global Triggered
    ; LeaderPressed: 记录 leader 键状态
    global LeaderPressed

$Space::
    Triggered:=false
    LeaderPressed:=true

    SetTimer, setTriggered, -300

    ; 等待 leader 鍵弹起
    KeyWait, Space
    LeaderPressed:=false
    if !Triggered
    {
        try
        runFunc("keyFunc_space")
    }

    if(winTapedX!=-1)
    {
        winsSort(winTapedX)
    }

Return

setTriggered:
    Triggered:=true
Return

#If LeaderPressed
; free keys: bip

; ---------------------------- move ----------------------------
d::runFunc("keyFunc_moveWordLeft")
f::runFunc("keyFunc_moveLeft")
j::runFunc("keyFunc_moveRight")
k::runFunc("keyFunc_moveWordRight")
l::runFunc("keyFunc_end")
m::runFunc("keyFunc_moveDown")
r::runFunc("keyFunc_moveUp")
s::runFunc("keyFunc_home")
w::runFunc("keyFunc_moveToPageBeginning")
.::runFunc("keyFunc_moveToPageEnd")

; ---------------------------- select ----------------------------
a & d::runFunc("keyFunc_selectWordLeft")
a & f::runFunc("keyFunc_selectLeft")
a & j::runFunc("keyFunc_selectRight")
a & k::runFunc("keyFunc_selectWordRight")
a & l::runFunc("keyFunc_selectEnd")
a & m::runFunc("keyFunc_selectDown")
a & r::runFunc("keyFunc_selectUp")
a & s::runFunc("keyFunc_selectHome")
a & w::runFunc("keyFunc_selectToPageBeginning")
a & .::runFunc("keyFunc_selectToPageEnd")

`; & d::runFunc("keyFunc_selectWordLeft")
`; & f::runFunc("keyFunc_selectLeft")
`; & j::runFunc("keyFunc_selectRight")
`; & k::runFunc("keyFunc_selectWordRight")
`; & l::runFunc("keyFunc_selectEnd")
`; & m::runFunc("keyFunc_selectDown")
`; & r::runFunc("keyFunc_selectUp")
`; & s::runFunc("keyFunc_selectHome")
`; & w::runFunc("keyFunc_selectToPageBeginning")
`; & .::runFunc("keyFunc_selectToPageEnd")

; ---------------------------- win bind ----------------------------
#1::runFunc("keyFunc_winbind_binding(1)")
#2::runFunc("keyFunc_winbind_binding(2)")
#3::runFunc("keyFunc_winbind_binding(3)")
#4::runFunc("keyFunc_winbind_binding(4)")
#5::runFunc("keyFunc_winbind_binding(5)")
#6::runFunc("keyFunc_winbind_binding(6)")
#7::runFunc("keyFunc_winbind_binding(7)")
#8::runFunc("keyFunc_winbind_binding(8)")
#9::runFunc("keyFunc_winbind_binding(9)")
#0::runFunc("keyFunc_winbind_binding(10)")

; ---------------------------- win activite ----------------------------
1::runFunc("keyFunc_winbind_activate(1)")
2::runFunc("keyFunc_winbind_activate(2)")
3::runFunc("keyFunc_winbind_activate(3)")
4::runFunc("keyFunc_winbind_activate(4)")
5::runFunc("keyFunc_winbind_activate(5)")
6::runFunc("keyFunc_winbind_activate(6)")
7::runFunc("keyFunc_winbind_activate(7)")
8::runFunc("keyFunc_winbind_activate(8)")
9::runFunc("keyFunc_winbind_activate(9)")
0::runFunc("keyFunc_winbind_activate(10)")

; ---------------------------- misc ----------------------------
WheelUp::runFunc("keyFunc_winTransIncrease")
WheelDown::runFunc("keyFunc_winTransDecrease")

c::runFunc("keyFunc_copy")
e::runFunc("keyFunc_goToPreTab")
g::runFunc("keyFunc_selectCurrentLine")
h::runFunc("keyFunc_selectCurrentWord")
n::runFunc("keyFunc_goToNextTab")
o::runFunc("keyFunc_delete")
q::runFunc("keyFunc_goBack")
t::runFunc("keyFunc_goForward")
u::runFunc("keyFunc_backspace")
v::runFunc("keyFunc_paste")
x::runFunc("keyFunc_cut")
y::runFunc("keyFunc_redo")
z::runFunc("keyFunc_undo")

F3::runFunc("keyFunc_translate")
F5::runFunc("keyFunc_reload")
F6::runFunc("keyFunc_winPin")

,::runFunc("keyFunc_goToDefinition")

#If

GuiClose:
GuiEscape:
    Gui, Cancel
Return