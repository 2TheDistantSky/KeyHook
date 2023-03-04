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

/* need MetaGo extension */
FuncBracketJmp()
{
    SendInput "+^{\}"
}

FuncGoTo()
{
    SendInput "!{/}"
}

FuncDelTo()
{
    SendInput "!{d}"
}

FuncChgPair()
{
    SendInput "!{p}"
}

FuncSelectPair()
{
    SendInput "+!{p}"
}

FuncSelectTo()
{
    SendInput "+!{/}"
}

FuncTogBk()
{
    SendInput "!{'}"
}

FuncViewBk()
{
    SendInput "!{\}"
}

FuncPreBk()
{
    SendInput "!{[}"
}

FuncNextBk()
{
    SendInput "!{]}"
}