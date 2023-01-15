#SingleInstance Force

F5:: Reload

global wins := Array()
global WinsInfoFileName := "wins_info.json"

WinBindInit()
{
    global wins
    global WinsInfoFileName

    winInfo := Map(
        "bindType", 0,
        "id", "",
        "class", "",
        "exe", ""
    )

    if (!FileExist(WinsInfoFileName)) {
        winArray := Array()
        Loop 10 {
            winArray.Push(winInfo)
        }

        FileAppend(JSON.stringify(winArray), WinsInfoFileName)
    }

    wins := JSON.parse(FileRead(WinsInfoFileName))
}


GetWinInfo(btnx)
{
    global wins
    global WinsInfoFileName

    bindType := 1

    ;获取窗口的 id
    winId := WinExist("A")
    if (winId == 0) {
        return
    }
    ;获取窗口的 class
    winClass := WinGetClass(winId)
    ;获取窗口的 exe
    winExe := WinGetProcessExe(winId)
    ;获取窗口的 exe
    winExe := WinGetTitle(winId)

    ;如果是单窗口绑定
    if (bindType == 1) {
        info := Map(
            "bindType", 1,
            "id", winId,
            "class", winClass,
            "exe", winExe
        )
        wins.RemoveAt(btnx + 1)
        wins.InsertAt(btnx + 1, info)

        FileDelete(WinsInfoFileName)
        FileAppend(JSON.stringify(wins), WinsInfoFileName)
    }
}

ActivateWinAction(btnx)
{
    ; HotIfWinNotExist wins[btnx + 1]["id"]
    ; tempClass := wins[btnx + 1]["class"]
    ; tempExe := wins[btnx + 1]["exe"]
    ; tempId := WinGetID(tempClass)
    ; MsgBox(tempId)
    ; WinGet,
    ;     tempId,
    ;     ID,
    ;     ahk_exe %tempExe% ahk_class %tempClass%
    ; if (tempId) {
    ;     IniWrite, %tempId%, winsInfo.ini, %btnx, id_0
    ; } else {
    ;     IfExist, %tempExe%
    ;     {
    ;         Run, %tempExe%
    ;     }
    ;     Return
    ; }
    ; HotIfWinNotExist
    ; IfWinActive,
    ;     ahk_id %tempId% {
    ;         WinMinimize,
    ;         ahk_id %tempId%
    ;         if (lastActiveWinId != "" && lastActiveWinId != tempId)
    ;             WinActivate, ahk_id %lastActiveWinId%
    ;             Return
    ;         }
    ;         lastActiveWinId := WinExist("A")
    ;         WinActivate,
    ;         ahk_id %tempId%
    ;         Return

    ; HotIfWinExist wins[btnx + 1]["id"]
    ; tempClass := wins[btnx + 1]["class"]
    ; tempExe := wins[btnx + 1]["exe"]
    ; tempId := WinGetID(tempClass)
    ; MsgBox(tempId)
    ; HotIfWinExist

    if (wins[btnx + 1]["bindType"] == 0) {
        return
    }
    if (WinExist("ahk_id" wins[btnx + 1]["id"])) {
        MsgBox(wins[btnx + 1]["id"])
        WinActivate("ahk_id" wins[btnx + 1]["id"])
    } else {
        Run("ahk_exe" wins[btnx + 1]["exe"])
        id := WinGetID()
        MsgBox(id)
        ; id := WinGetID(wins[btnx + 1]["class"])
        ; info := Map(
        ;     "bindType", 1,
        ;     "id", id,
        ;     "class", wins[btnx + 1]["class"],
        ;     "exe", wins[btnx + 1]["exe"]
        ; )
        ; wins.RemoveAt(btnx + 1)
        ; wins.InsertAt(btnx + 1, info)

        ; FileDelete(WinsInfoFileName)
        ; FileAppend(JSON.stringify(wins), WinsInfoFileName)
    }

}


WinBindInit()
F1:: GetWinInfo(1)
F2:: ActivateWinAction(1)
F3:: WinActivate "ahk_class ConsoleWindowClass"
F4:: WinActivate "计算器"

F6::MsgBox(WinGetClass("A"))