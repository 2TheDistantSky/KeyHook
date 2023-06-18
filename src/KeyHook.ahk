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
; 选择模式
global selectMode := false

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

#HotIf leaderPressed && selectMode
d:: RunFunc("FuncSelectWordLeft")
f:: RunFunc("FuncSelectLeft")
j:: RunFunc("FuncSelectRight")
k:: RunFunc("FuncSelectWordRight")
l:: RunFunc("FuncSelectEnd")
m:: RunFunc("FuncSelectDown")
r:: RunFunc("FuncSelectUp")
s:: RunFunc("FuncSelectHome")
w:: RunFunc("FuncSelectToPageBeginning")
.:: RunFunc("FuncSelectToPageEnd")
#HotIf

#HotIf leaderPressed && !selectMode
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
#HotIf

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

#HotIf leaderPressed
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

b:: RunFunc("FuncBracketJmp")
c:: RunFunc("FuncTogBk")
e:: RunFunc("FuncGoToPreTab")
g:: RunFunc("FuncGoTo")
h:: RunFunc("FuncSelectTo")
i:: RunFunc("FuncSelectPair")
n:: RunFunc("FuncGoToNextTab")
o:: RunFunc("FuncDelete")
p:: RunFunc("FuncChgPair")
q:: RunFunc("FuncGoBack")
t:: RunFunc("FuncGoForward")
u:: RunFunc("FuncBackspace")
v:: RunFunc("FuncTogMode")
x:: RunFunc("FuncDelTo")
y:: RunFunc("FuncRedo")
z:: RunFunc("FuncUndo")

,:: RunFunc("FuncGoToDefinition")
[:: RunFunc("FuncPreBk")
]:: RunFunc("FuncNextBk")

F5:: RunFunc("FuncReload")
F6:: RunFunc("ToggleWinPin")

; ---------------------------- LAlt ----------------------------
<!r::!Up
<!m::!Down
<!f::!Left
<!j::!Right
<!s::!Home
<!l::!End

#include customized_cfg.ahk

#HotIf