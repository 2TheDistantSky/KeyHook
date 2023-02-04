WinTransIncrease()
{
    winId := WinExist("A")
    trans := WinGetTransparent(winId)
    if (!trans) {
        return
    }

    trans := (trans + 10 > 255) ? 255 : (trans + 10)
    WinSetTransparent(trans, winId)

    if (trans == 255) {
        WinSetTransparent("Off", winId)
        WinRedraw(winId)
    }
}

WinTransDecrease()
{
    winId := WinExist("A")
    trans := WinGetTransparent(winId)
    if (!trans) {
        trans := 255
    }

    trans := (trans - 10 < 15) ? 15 : (trans - 10)

    WinSetTransparent(trans, winId)
}