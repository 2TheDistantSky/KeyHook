FuncMoveLeft(i := 1)
{
    Loop i {
        SendInput "{Left}"
    }
}

FuncMoveRight(i := 1)
{
    Loop i {
        SendInput "{Right}"
    }
}

FuncMoveUp(i := 1)
{
    Loop i {
        SendInput "{Up}"
    }
}

FuncMoveDown(i := 1)
{
    Loop i {
        SendInput "{Down}"
    }
}

FuncMoveWordLeft(i := 1)
{
    Loop i {
        SendInput "^{Left}"
    }
}

FuncMoveWordRight(i := 1)
{
    Loop i {
        SendInput "^{Right}"
    }
}

FuncBackspace()
{
    SendInput "{Backspace}"
}

FuncDelete()
{
    SendInput "{Delete}"
}

FuncEnd()
{
    SendInput "{End}"
}

FuncHome()
{
    SendInput "{Home}"
}

FuncMoveToPageBeginning()
{
    SendInput "^{Home}"
}

FuncMoveToPageEnd()
{
    SendInput "^{End}"
}

FuncSpace()
{
    Send "{Space}"
}

FuncUndo()
{
    SendInput "^{z}"
}

FuncRedo()
{
    SendInput "^{y}"
}

FuncCopy()
{
    SendInput "^{c}"
}

FuncCut()
{
    SendInput "^{x}"
}

FuncPaste()
{
    SendInput "^{v}"
}

FuncSelectUp(i := 1)
{
    Loop i {
        SendInput "+{Up}"
    }
}

FuncSelectDown(i := 1)
{
    Loop i {
        SendInput "+{Down}"
    }
}

FuncSelectLeft(i := 1)
{
    Loop i {
        SendInput "+{Left}"
    }
}

FuncSelectRight(i := 1)
{
    Loop i {
        SendInput "+{Right}"
    }
}

FuncSelectHome()
{
    SendInput "+{Home}"
}

FuncSelectEnd()
{
    SendInput "+{End}"
}

FuncSelectToPageBeginning()
{
    SendInput "+^{Home}"
}

FuncSelectToPageEnd()
{
    SendInput "+^{End}"
}

FuncSelectCurrentWord()
{
    SendInput "^{Left}"
    SendInput "+^{Right}"
}

FuncSelectCurrentLine()
{
    SendInput "{Home}"
    SendInput "+{End}"
}

FuncSelectWordLeft(i := 1)
{
    Loop i {
        SendInput "+^{Left}"
    }
}

FuncSelectWordRight(i := 1)
{
    Loop i {
        SendInput "+^{Right}"
    }
}

FuncReload()
{
    MsgBox("reloading......", "KeyHook", "T0.5")
    Reload
}

FuncWinPin()
{
    WinSetAlwaysOnTop -1, "A"
}

FuncGoToDefinition()
{
    SendInput "{F12}"
}

FuncGoForward()
{
    SendInput "!{Right}"
}

FuncGoBack()
{
    SendInput "!{Left}"
}

FuncGoToPreTab()
{
    SendInput "^{PgUp}"
}

FuncGoToNextTab()
{
    SendInput "^{PgDn}"
}

FuncSendStr(str, winTitle:="A")
{
    BlockInput(True)
    ctl := ControlGetFocus(winTitle)
    if ctl
    {
        loop parse, str
            PostMessage(0x102, ord(A_LoopField),, ctl, winTitle)
    }
    else
    {
        loop parse, str
            PostMessage(0x102, Ord(A_LoopField),,, winTitle) ;必须留空
    }
    BlockInput(False)

    ; 说明 在QQ聊天窗口中是乱码，需要发送UTF-16BE编码
}

FuncWinTransIncrease()
{
    winId := WinExist("A")
    trans := WinGetTransparent(winId)
    if (!trans) {
        Return
    }

    trans := (trans + 10 > 255) ? 255 : (trans + 10)
    WinSetTransparent(trans, winId)

    if (trans == 255) {
        WinSetTransparent("Off", winId)
        WinRedraw(winId)
    }
}

FuncWinTransDecrease()
{
    winId := WinExist("A")
    trans := WinGetTransparent(winId)
    if (!trans) {
        trans := 255
    }

    trans := (trans - 10 < 15) ? 15 : (trans - 10)

    WinSetTransparent(trans, winId)
}

;winbind-------------
; FuncWinbind_activate(n){
;     global
;     activateWinAction(n)
; }