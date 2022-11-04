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

;---------------------------- win transparent -----------------------------
WheelUp::
    try
    runFunc("keyFunc_winTransIncrease")
Return

WheelDown::
    try
    runFunc("keyFunc_winTransDecrease")
Return

;---------------------------- move -----------------------------
d::
    try
    runFunc("keyFunc_moveWordLeft")
Return

f::
    try
    runFunc("keyFunc_moveLeft")
Return

j::
    try
    runFunc("keyFunc_moveRight")
Return

k::
    try
    runFunc("keyFunc_moveWordRight")
Return

l::
    try
    runFunc("keyFunc_end")
Return

m::
    try
    runFunc("keyFunc_moveDown")
Return

r::
    try
    runFunc("keyFunc_moveUp")
Return

s::
    try
    runFunc("keyFunc_home")
Return

w::
    try
    runFunc("keyFunc_moveToPageBeginning")
Return

.::
    try
    runFunc("keyFunc_moveToPageEnd")
Return

;---------------------------- select -----------------------------
a & w::
    try
    runFunc("keyFunc_selectToPageBeginning")
Return

a & r::
    try
    runFunc("keyFunc_selectUp")
Return

a & s::
    try
    runFunc("keyFunc_selectHome")
Return

a & d::
    try
    runFunc("keyFunc_selectWordLeft")
Return

a & f::
    try
    runFunc("keyFunc_selectLeft")
Return

a & j::
    try
    runFunc("keyFunc_selectRight")
Return

a & k::
    try
    runFunc("keyFunc_selectWordRight")
Return

a & l::
    try
    runFunc("keyFunc_selectEnd")
Return

a & m::
    try
    runFunc("keyFunc_selectDown")
Return

a & .::
    try
    runFunc("keyFunc_selectToPageEnd")
Return

`; & w::
try
runFunc("keyFunc_selectToPageBeginning")
Return

`; & r::
try
runFunc("keyFunc_selectUp")
Return

`; & s::
try
runFunc("keyFunc_selectHome")
Return

`; & d::
try
runFunc("keyFunc_selectWordLeft")
Return

`; & f::
try
runFunc("keyFunc_selectLeft")
Return

`; & j::
try
runFunc("keyFunc_selectRight")
Return

`; & k::
try
runFunc("keyFunc_selectWordRight")
Return

`; & l::
try
runFunc("keyFunc_selectEnd")
Return

`; & m::
try
runFunc("keyFunc_selectDown")
Return

`; & .::
try
runFunc("keyFunc_selectToPageEnd")
Return

;---------------------------- win bind -----------------------------
#1::
    try
    runFunc("keyFunc_winbind_binding(1)")
Return

#2::
    try
    runFunc("keyFunc_winbind_binding(2)")
Return

#3::
    try
    runFunc("keyFunc_winbind_binding(3)")
Return

#4::
    try
    runFunc("keyFunc_winbind_binding(4)")
Return

#5::
    try
    runFunc("keyFunc_winbind_binding(5)")
Return

#6::
    try
    runFunc("keyFunc_winbind_binding(6)")
Return

#7::
    try
    runFunc("keyFunc_winbind_binding(7)")
Return

#8::
    try
    runFunc("keyFunc_winbind_binding(8)")
Return

#9::
    try
    runFunc("keyFunc_winbind_binding(9)")
Return

#0::
    try
    runFunc("keyFunc_winbind_binding(10)")
Return

;---------------------------- win activite -----------------------------
1::
    try
    runFunc("keyFunc_winbind_activate(1)")
Return

2::
    try
    runFunc("keyFunc_winbind_activate(2)")
Return

3::
    try
    runFunc("keyFunc_winbind_activate(3)")
Return

4::
    try
    runFunc("keyFunc_winbind_activate(4)")
Return

5::
    try
    runFunc("keyFunc_winbind_activate(5)")
Return

6::
    try
    runFunc("keyFunc_winbind_activate(6)")
Return

7::
    try
    runFunc("keyFunc_winbind_activate(7)")
Return

8::
    try
    runFunc("keyFunc_winbind_activate(8)")
Return

9::
    try
    runFunc("keyFunc_winbind_activate(9)")
Return

0::
    try
    runFunc("keyFunc_winbind_activate(10)")
Return

;---------------------------- misc -----------------------------
c::
    try
    runFunc("keyFunc_copy")
Return

q::
    try
    runFunc("keyFunc_goBack")
Return

t::
    try
    runFunc("keyFunc_goForward")
Return

v::
    try
    runFunc("keyFunc_paste")
Return

x::
    try
    runFunc("keyFunc_cut")
Return

y::
    try
    runFunc("keyFunc_redo")
Return

z::
    try
    runFunc("keyFunc_undo")
Return

F3::
    try
    runFunc("keyFunc_translate")
Return

F5::
    try
    runFunc("keyFunc_reload")
Return

F6::
    try
    runFunc("keyFunc_winPin")
Return

#If

GuiClose:
GuiEscape:
    Gui, Cancel
Return