#SingleInstance force
#MaxHotkeysPerInterval 500
#NoEnv
Process Priority,,High

#Include components
#Include init.ahk
#Include keys_function.ahk
#Include keyset.ahk
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
        runFunc(keyset.press_space)
    }

    if(winTapedX!=-1)
    {
        winsSort(winTapedX)
    }

Return

setTriggered:
    Triggered:=true
Return

;----------------------------keys-set-start-----------------------------
#If LeaderPressed

LAlt::Return

WheelUp::
    try
    runFunc(keyset.leader_wheelUp)
Return

WheelDown::
    try
    runFunc(keyset.leader_wheelDown)
Return

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
Return

`::
    try
    runFunc(keyset.leader_backQuote)
Return

-::
    try
    runFunc(keyset.leader_minus)
Return

=::
    try
    runFunc(keyset.leader_equal)
Return

[::
    try
    runFunc(keyset.leader_leftSquareBracket)
Return

]::
    try
    runFunc(keyset.leader_rightSquareBracket)
Return

\::
    try
    runFunc(keyset.leader_backslash)
Return

`;::
try
runFunc(keyset.leader_semicolon)
Triggered:=true
Return

'::
    try
    runFunc(keyset.leader_quote)
Return

,::
    try
    runFunc(keyset.leader_comma)
Return

.::
    try
    runFunc(keyset.leader_dot)
Return

/::
    try
    runFunc(keyset.leader_slash)
Return

;  RAlt::
;  try
;      runFunc(keyset.leader_ralt)
;  Triggered:=true
;  Return

;---------------------caps+lalt----------------

<!a::
    try
    runFunc(keyset.leader_lalt_a)
Return

<!b::
    try
    runFunc(keyset.leader_lalt_b)
Return

<!c::
    try
    runFunc(keyset.leader_lalt_c)
Return

<!d::
    try
    runFunc(keyset.leader_lalt_d)
Return

<!e::
    try
    runFunc(keyset.leader_lalt_e)
Return

<!f::
    try
    runFunc(keyset.leader_lalt_f)
Return

<!g::
    try
    runFunc(keyset.leader_lalt_g)
Return

<!h::
    try
    runFunc(keyset.leader_lalt_h)
Return

<!i::
    try
    runFunc(keyset.leader_lalt_i)
Return

<!j::
    try
    runFunc(keyset.leader_lalt_j)
Return

<!k::
    try
    runFunc(keyset.leader_lalt_k)
Return

<!l::
    try
    runFunc(keyset.leader_lalt_l)
Return

<!m::
    try
    runFunc(keyset.leader_lalt_m)
Return

<!n::
    try
    runFunc(keyset.leader_lalt_n)
Return

<!o::
    try
    runFunc(keyset.leader_lalt_o)
Return

<!p::
    try
    runFunc(keyset.leader_lalt_p)
Return

<!q::
    try
    runFunc(keyset.leader_lalt_q)
Return

<!r::
    try
    runFunc(keyset.leader_lalt_r)
Return

<!s::
    try
    runFunc(keyset.leader_lalt_s)
Return

<!t::
    try
    runFunc(keyset.leader_lalt_t)
Return

<!u::
    try
    runFunc(keyset.leader_lalt_u)
Return

<!v::
    try
    runFunc(keyset.leader_lalt_v)
Return

<!w::
    try
    runFunc(keyset.leader_lalt_w)
Return

<!x::
    try
    runFunc(keyset.leader_lalt_x)
Return

<!y::
    try
    runFunc(keyset.leader_lalt_y)
Return

<!z::
    try
    runFunc(keyset.leader_lalt_z)
Return

<!`::
    runFunc(keyset.leader_lalt_backquote)
Return

<!1::
    try
    runFunc(keyset.leader_lalt_1)
Return

<!2::
    try
    runFunc(keyset.leader_lalt_2)
Return

<!3::
    try
    runFunc(keyset.leader_lalt_3)
Return

<!4::
    try
    runFunc(keyset.leader_lalt_4)
Return

<!5::
    try
    runFunc(keyset.leader_lalt_5)
Return

<!6::
    try
    runFunc(keyset.leader_lalt_6)
Return

<!7::
    try
    runFunc(keyset.leader_lalt_7)
Return

<!8::
    try
    runFunc(keyset.leader_lalt_8)
Return

<!9::
    try
    runFunc(keyset.leader_lalt_9)
Return

<!0::
    try
    runFunc(keyset.leader_lalt_0)
Return

<!-::
    try
    runFunc(keyset.leader_lalt_minus)
Return

<!=::
    try
    runFunc(keyset.leader_lalt_equal)
Return

<!BackSpace::
    try
    runFunc(keyset.leader_lalt_backspace)
Return

<!Tab::
    try
    runFunc(keyset.leader_lalt_tab)
Return

<![::
    try
    runFunc(keyset.leader_lalt_leftSquareBracket)
Return

<!]::
    try
    runFunc(keyset.leader_lalt_rightSquareBracket)
Return

<!\::
    try
    runFunc(keyset.leader_lalt_Backslash)
Return

<!`;::
try
runFunc(keyset.leader_lalt_semicolon)
Triggered:=true
Return

<!'::
    try
    runFunc(keyset.leader_lalt_quote)
Return

<!Enter::
    try
    runFunc(keyset.leader_lalt_enter)
Return

<!,::
    try
    runFunc(keyset.leader_lalt_comma)
Return

<!.::
    try
    runFunc(keyset.leader_lalt_dot)
Return

<!/::
    try
    runFunc(keyset.leader_lalt_slash)
Return

<!Space::
    try
    runFunc(keyset.leader_lalt_space)
Return

<!RAlt::
    try
    runFunc(keyset.leader_lalt_ralt)
Return

<!F1::
    try
    runFunc(keyset.leader_lalt_f1)
Return

<!F2::
    try
    runFunc(keyset.leader_lalt_f2)
Return

<!F3::
    try
    runFunc(keyset.leader_lalt_f3)
Return

<!F4::
    try
    runFunc(keyset.leader_lalt_f4)
Return

<!F5::
    try
    runFunc(keyset.leader_lalt_f5)
Return

<!F6::
    try
    runFunc(keyset.leader_lalt_f6)
Return

<!F7::
    try
    runFunc(keyset.leader_lalt_f7)
Return

<!F8::
    try
    runFunc(keyset.leader_lalt_f8)
Return

<!F9::
    try
    runFunc(keyset.leader_lalt_f9)
Return

<!F10::
    try
    runFunc(keyset.leader_lalt_f10)
Return

<!F11::
    try
    runFunc(keyset.leader_lalt_f11)
Return

<!F12::
    try
    runFunc(keyset.leader_lalt_f12)
Return

#1::
    try
    runFunc(keyset.leader_win_1)
Return

#2::
    try
    runFunc(keyset.leader_win_2)
Return

#3::
    try
    runFunc(keyset.leader_win_3)
Return

#4::
    try
    runFunc(keyset.leader_win_4)
Return

#5::
    try
    runFunc(keyset.leader_win_5)
Return

#6::
    try
    runFunc(keyset.leader_win_6)
Return

#7::
    try
    runFunc(keyset.leader_win_7)
Return

#8::
    try
    runFunc(keyset.leader_win_8)
Return

#9::
    try
    runFunc(keyset.leader_win_9)
Return

#0::
    try
    runFunc(keyset.leader_win_0)
Return

;  #s::
;      keyFunc_activateSideWin("l")
;  Triggered:=true
;  Return

;  #f::
;      keyFunc_activateSideWin("r")
;  ;  Return

;  #e::
;      keyFunc_activateSideWin("u")
;  Triggered:=true
;  Return

;  #d::
;      keyFunc_activateSideWin("d")
;  ;  Return

;  #w::
;      keyFunc_putWinToBottom()
;  ;  Return

;  #a::
;      keyFunc_activateSideWin("fl")
;  ;  Return

;  #g::
;      keyFunc_activateSideWin("fr")
;  ;  Return

;  #z::
;      keyFunc_clearWinMinimizeStach()
;  ;  Return

;  #x::
;      keyFunc_inWinMinimizeStack(true)
;  ;  Return

;  #c::
;      keyFunc_inWinMinimizeStack()
;  ;  Return

;  #v::
;      keyFunc_outWinMinimizeStack()
;  ;  Return

#If

GuiClose:
GuiEscape:
    Gui, Cancel
Return