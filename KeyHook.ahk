#SingleInstance Force

#Include components
; #Include init.ahk
#Include keys_function.ahk
; #Include youdao_translate.ahk
; #Include functions.ahk
#Include bind_wins.ahk
; #Include win_jump.ahk

; Triggered: 此次按键事件是否触发了修改后的热键
global Triggered := False
; LeaderPressed: 记录 leader 键状态
global LeaderPressed := False

RunFunc(str)
{
    Triggered := True
    ;如果只给了函数名，没有括号，当做是不传参直接调用函数
    if(!RegExMatch(Trim(str), "\)$"))
    {
        %str%()
        Return
    }
    ; if(RegExMatch(str, "(\w+)\((.*)\)$", match))
    ; {
    ;     func := Func(match1)

    ;     if(!match2) {
    ;         func.()
    ;         Return
    ;     }

    ;     params:={}
    ;     loop, Parse, match2, CSV
    ;     {
    ;         params.insert(A_LoopField)
    ;     }

    ;     parmasLen:=params.MaxIndex()

    ;     if(parmasLen==1)
    ;     {
    ;         func.(params[1])
    ;         Return
    ;     }
    ;     if(parmasLen==2)
    ;     {
    ;         func.(params[1],params[2])
    ;         Return
    ;     }
    ;     if(parmasLen==3)
    ;     {
    ;         func.(params[1],params[2],params[3])
    ;         Return
    ;     }
    ; }
}

$Space::
    {
        global Triggered
        global LeaderPressed

        Triggered := False
        LeaderPressed := True

        SetTimer SetTriggered, -300

        ; 等待 leader 键弹起
        KeyWait "Space"
        LeaderPressed := False
        if (!Triggered) {
            RunFunc("FuncSpace")
        }
    }

SetTriggered()
{
    global Triggered

    Triggered := True
}

#HotIf LeaderPressed

; free keys: abip
; ---------------------------- move ----------------------------
d::RunFunc("FuncMoveWordLeft")
f::RunFunc("FuncMoveLeft")
j::RunFunc("FuncMoveRight")
k::RunFunc("FuncMoveWordRight")
l::RunFunc("FuncEnd")
m::RunFunc("FuncMoveDown")
r::RunFunc("FuncMoveUp")
s::RunFunc("FuncHome")
w::RunFunc("FuncMoveToPageBeginning")
.::RunFunc("FuncMoveToPageEnd")

; ---------------------------- select ----------------------------
Ctrl & d::RunFunc("FuncSelectWordLeft")
Ctrl & f::RunFunc("FuncSelectLeft")
Ctrl & j::RunFunc("FuncSelectRight")
Ctrl & k::RunFunc("FuncSelectWordRight")
Ctrl & l::RunFunc("FuncSelectEnd")
Ctrl & m::RunFunc("FuncSelectDown")
Ctrl & r::RunFunc("FuncSelectUp")
Ctrl & s::RunFunc("FuncSelectHome")
Ctrl & w::RunFunc("FuncSelectToPageBeginning")
Ctrl & .::RunFunc("FuncSelectToPageEnd")

a & d::RunFunc("FuncSelectWordLeft")
a & f::RunFunc("FuncSelectLeft")
a & j::RunFunc("FuncSelectRight")
a & k::RunFunc("FuncSelectWordRight")
a & l::RunFunc("FuncSelectEnd")
a & m::RunFunc("FuncSelectDown")
a & r::RunFunc("FuncSelectUp")
a & s::RunFunc("FuncSelectHome")
a & w::RunFunc("FuncSelectToPageBeginning")
a & .::RunFunc("FuncSelectToPageEnd")

`; & d::RunFunc("FuncSelectWordLeft")
`; & f::RunFunc("FuncSelectLeft")
`; & j::RunFunc("FuncSelectRight")
`; & k::RunFunc("FuncSelectWordRight")
`; & l::RunFunc("FuncSelectEnd")
`; & m::RunFunc("FuncSelectDown")
`; & r::RunFunc("FuncSelectUp")
`; & s::RunFunc("FuncSelectHome")
`; & w::RunFunc("FuncSelectToPageBeginning")
`; & .::RunFunc("FuncSelectToPageEnd")

; ---------------------------- win bind ----------------------------
; #1::RunFunc("FuncWinbind_binding(1)")
; #2::RunFunc("FuncWinbind_binding(2)")
; #3::RunFunc("FuncWinbind_binding(3)")
; #4::RunFunc("FuncWinbind_binding(4)")
; #5::RunFunc("FuncWinbind_binding(5)")
; #6::RunFunc("FuncWinbind_binding(6)")
; #7::RunFunc("FuncWinbind_binding(7)")
; #8::RunFunc("FuncWinbind_binding(8)")
; #9::RunFunc("FuncWinbind_binding(9)")
; #0::RunFunc("FuncWinbind_binding(10)")

; ---------------------------- win activite ----------------------------
; 1::RunFunc("FuncWinbind_activate(1)")
; 2::RunFunc("FuncWinbind_activate(2)")
; 3::RunFunc("FuncWinbind_activate(3)")
; 4::RunFunc("FuncWinbind_activate(4)")
; 5::RunFunc("FuncWinbind_activate(5)")
; 6::RunFunc("FuncWinbind_activate(6)")
; 7::RunFunc("FuncWinbind_activate(7)")
; 8::RunFunc("FuncWinbind_activate(8)")
; 9::RunFunc("FuncWinbind_activate(9)")
; 0::RunFunc("FuncWinbind_activate(10)")

; ---------------------------- misc ----------------------------
WheelUp::RunFunc("FuncWinTransIncrease")
WheelDown::RunFunc("FuncWinTransDecrease")

c::RunFunc("FuncCopy")
e::RunFunc("FuncGoToPreTab")
g::RunFunc("FuncSelectCurrentLine")
h::RunFunc("FuncSelectCurrentWord")
n::RunFunc("FuncGoToNextTab")
o::RunFunc("FuncDelete")
q::RunFunc("FuncGoBack")
t::RunFunc("FuncGoForward")
u::RunFunc("FuncBackspace")
v::RunFunc("FuncPaste")
x::RunFunc("FuncCut")
y::RunFunc("FuncRedo")
z::RunFunc("FuncUndo")

,::RunFunc("FuncGoToDefinition")

; F3::RunFunc("keyFunc_translate")
F5::RunFunc("FuncReload")
F6::RunFunc("FuncWinPin")
#HotIf

; GuiClose:
; GuiEscape:
;     Gui, Cancel
; Return