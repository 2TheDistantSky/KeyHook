#Requires AutoHotkey >= 2.0
#SingleInstance Force

#include components/key_func.ahk
#include components/win_bind.ahk
#Include components/win_trans.ahk
#Include components/utils.ahk
#include components/init.ahk

; 此次按键事件是否触发了修改后的热键
global triggered := false
; 记录 leader 键状态
global leaderPressed := false

$Space::
{
    global triggered
    global leaderPressed

    triggered := false
    leaderPressed := true

    SetTimer(SetTriggered, -300)

    ; 等待 leader 键弹起
    KeyWait("Space")
    leaderPressed := false
    if (!triggered) {
        RunFunc("FuncSpace")
    }
}

SetTriggered()
{
    global triggered

    triggered := true
}

#HotIf leaderPressed

; free keys: abip
; ---------------------------- move ----------------------------
d:: RunFunc("FuncMoveWordLeft")
f:: RunFunc("FuncMoveLeft")
j:: RunFunc("FuncMoveRight")
k:: RunFunc("FuncMoveWordRight")
l:: RunFunc("FuncEnd")
m:: RunFunc("FuncMoveDown")
r:: RunFunc("FuncMoveUp")
s:: RunFunc("FuncHome")
w:: RunFunc("FuncMoveToPageBeginning")
.:: RunFunc("FuncMoveToPageEnd")

; ---------------------------- select ----------------------------
Ctrl & d:: RunFunc("FuncSelectWordLeft")
Ctrl & f:: RunFunc("FuncSelectLeft")
Ctrl & j:: RunFunc("FuncSelectRight")
Ctrl & k:: RunFunc("FuncSelectWordRight")
Ctrl & l:: RunFunc("FuncSelectEnd")
Ctrl & m:: RunFunc("FuncSelectDown")
Ctrl & r:: RunFunc("FuncSelectUp")
Ctrl & s:: RunFunc("FuncSelectHome")
Ctrl & w:: RunFunc("FuncSelectToPageBeginning")
Ctrl & .:: RunFunc("FuncSelectToPageEnd")

a & d:: RunFunc("FuncSelectWordLeft")
a & f:: RunFunc("FuncSelectLeft")
a & j:: RunFunc("FuncSelectRight")
a & k:: RunFunc("FuncSelectWordRight")
a & l:: RunFunc("FuncSelectEnd")
a & m:: RunFunc("FuncSelectDown")
a & r:: RunFunc("FuncSelectUp")
a & s:: RunFunc("FuncSelectHome")
a & w:: RunFunc("FuncSelectToPageBeginning")
a & .:: RunFunc("FuncSelectToPageEnd")

`; & d:: RunFunc("FuncSelectWordLeft")
`; & f:: RunFunc("FuncSelectLeft")
`; & j:: RunFunc("FuncSelectRight")
`; & k:: RunFunc("FuncSelectWordRight")
`; & l:: RunFunc("FuncSelectEnd")
`; & m:: RunFunc("FuncSelectDown")
`; & r:: RunFunc("FuncSelectUp")
`; & s:: RunFunc("FuncSelectHome")
`; & w:: RunFunc("FuncSelectToPageBeginning")
`; & .:: RunFunc("FuncSelectToPageEnd")

; ---------------------------- win bind ----------------------------
#0:: RunFunc("GetWinInfo(0)")
#1:: RunFunc("GetWinInfo(1)")
#2:: RunFunc("GetWinInfo(2)")
#3:: RunFunc("GetWinInfo(3)")
#4:: RunFunc("GetWinInfo(4)")
#5:: RunFunc("GetWinInfo(5)")
#6:: RunFunc("GetWinInfo(6)")
#7:: RunFunc("GetWinInfo(7)")
#8:: RunFunc("GetWinInfo(8)")
#9:: RunFunc("GetWinInfo(9)")

; ---------------------------- win activite ----------------------------
0:: RunFunc("ActivateWin(0)")
1:: RunFunc("ActivateWin(1)")
2:: RunFunc("ActivateWin(2)")
3:: RunFunc("ActivateWin(3)")
4:: RunFunc("ActivateWin(4)")
5:: RunFunc("ActivateWin(5)")
6:: RunFunc("ActivateWin(6)")
7:: RunFunc("ActivateWin(7)")
8:: RunFunc("ActivateWin(8)")
9:: RunFunc("ActivateWin(9)")

; ---------------------------- misc ----------------------------
WheelUp:: RunFunc("WinTransIncrease")
WheelDown:: RunFunc("WinTransDecrease")

c:: RunFunc("FuncCopy")
e:: RunFunc("FuncGoToPreTab")
g:: RunFunc("FuncSelectCurrentLine")
h:: RunFunc("FuncSelectCurrentWord")
n:: RunFunc("FuncGoToNextTab")
o:: RunFunc("FuncDelete")
q:: RunFunc("FuncGoBack")
t:: RunFunc("FuncGoForward")
u:: RunFunc("FuncBackspace")
v:: RunFunc("FuncPaste")
x:: RunFunc("FuncCut")
y:: RunFunc("FuncRedo")
z:: RunFunc("FuncUndo")

,:: RunFunc("FuncGoToDefinition")

F5:: RunFunc("FuncReload")
F6:: RunFunc("ToggleWinPin")

#include customized_cfg.ahk

#HotIf