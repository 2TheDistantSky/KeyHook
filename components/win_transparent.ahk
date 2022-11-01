winTransparentInit:
    global winTranSetting, transpWinId, allowWinTranspToggle, transp

    ; 窗口透明度
    ;  transp:=CLSets.Global.mouseSpeed

Return

winTransparent(){
    if(!winTranSetting){ ; 按下按下后只有第一次生效
        winTranSetting:=true
        allowWinTranspToggle:=true

        transpWinId:=WinExist("A")

        WinGet, transp, Transparent, ahk_id %transpWinId%

        setTimer, winTranspKeyCheck, 50

        setTimer, checkIfTranspToggle, -300 ; 快速短按的话反转窗口的透明度
    }

Return
}

checkIfTranspToggle:
    allowWinTranspToggle:=false
Return

winTranspReduce:
    ;  if(!transp)
    ;      WinGet, transp, Transparent, ahk_id %transpWinId%
    if(!transp)
        transp:=245
    transp-=10
    if(transp<15)
        transp:=15

    WinSet, Transparent, %transp%, ahk_id %transpWinId%
Return

winTranspAdd:
    ;  if(!transp)
    ;      WinGet, transp, Transparent, ahk_id %transpWinId%
    if(!transp or transp=255)
        Return

    transp+=10
    if(transp>255){
        transp:=255
        WinSet, Transparent, off, ahk_id %transpWinId%
        WinSet, Redraw
        Return
    }

    WinSet, Transparent, %transp%, ahk_id %transpWinId%
Return

winTranspKeyCheck:
    if(!GetKeyState("f4", "P") || !Capslock){
        setTimer, checkIfTranspToggle, off ; 关闭短按切换透明度
        setTimer, winTranspKeyCheck, off

        if(allowWinTranspToggle){

            ;  WinGet, transp, Transparent, ahk_id %transpWinId%
            if(transp){
                WinSet, Transparent, off, ahk_id %transpWinId%
                WinSet, Redraw
            }
            else
                WinSet, Transparent, 170, ahk_id %transpWinId%
            ;  msgbox, 0
        }
        ;  msgbox,1
        winTranSetting:=false
        ;  transp:=""
    }
Return

#if winTranSetting

WheelUp::
    ;  send, 1
    gosub, winTranspAdd
Return

WheelDown::
    ;  send, 2
    gosub, winTranspReduce

    #if