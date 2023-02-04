global wins := Array()
global cfgFile := "wins_info.json"

WinBindInit()
{
    global wins
    global cfgFile

    winInfo := Map(
        "id", "",
        "class", "",
        "path", ""
    )

    if (!FileExist(cfgFile)) {
        winArray := Array()
        Loop 10 {
            winArray.Push(winInfo)
        }

        FileAppend(JSON.stringify(winArray), cfgFile)
    }

    wins := JSON.parse(FileRead(cfgFile))
}

SaveWinInfo()
{
    global wins
    global cfgFile

    FileDelete(cfgFile)
    FileAppend(JSON.stringify(wins), cfgFile)
}

GetWinInfo(btn)
{
    global wins

    btnx := btn + 1

    winId := WinExist("A")

    wins[btnx]["id"] := winId
    wins[btnx]["class"] := WinGetClass("ahk_id" winId)
    wins[btnx]["path"] := WinGetProcessPath("ahk_id" winId)

    SaveWinInfo()
}

ActivateWin(btn)
{
    global wins

    btnx := btn + 1

    if (WinExist("ahk_id " wins[btnx]["id"])) {
        if (WinActive("ahk_id" wins[btnx]["id"])) {
            WinMinimize("ahk_id" wins[btnx]["id"])
        } else {
            WinActivate("ahk_id" wins[btnx]["id"])
        }
    } else {
        tempId := WinExist("ahk_exe " wins[btnx]["path"] " ahk_class " wins[btnx]["class"])
        if (tempId != 0) {
            wins[btnx]["id"] := tempId
            SaveWinInfo()
        } else {
            try {
                Run(wins[btnx]["path"])
            }
        }
    }
}