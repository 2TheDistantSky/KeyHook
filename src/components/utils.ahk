RunFunc(str)
{
    triggered := true
    ;如果只给了函数名，没有括号，当做是不传参直接调用函数
    if (!RegExMatch(Trim(str), "\)$")) {
        %str%()
        return
    }
    if (RegExMatch(str, "(\w+)\((.*)\)$", &match)) {
        if (match.Count == 2) {
            %match[1]%(match[2])
            return
        }
    }
}

SendStr(str, winTitle := "A")
{
    ; 说明 在QQ聊天窗口中是乱码，需要发送UTF-16BE编码
    BlockInput(true)
    ctl := ControlGetFocus(winTitle)
    if ctl {
        loop parse, str
            PostMessage(0x102, ord(A_LoopField), , ctl, winTitle)
    } else {
        loop parse, str
            PostMessage(0x102, Ord(A_LoopField), , , winTitle)    ;必须留空
    }
    BlockInput(false)
}

ToggleWinPin()
{
    WinSetAlwaysOnTop -1, "A"
}