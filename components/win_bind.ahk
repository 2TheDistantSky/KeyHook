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
        "path", ""
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

    ;获取id
    winId := WinExist("A")
    ;获取该id窗口的class
    winClass := WinGetClass("A")
    ;获取该id窗口的path
    winPath := WinGetProcessPath("A")

    ;如果是单窗口绑定
    if (bindType == 1) {
        info := Map(
            "bindType", 1,
            "id", winId,
            "class", winClass,
            "path", winPath
        )
        wins.RemoveAt(btnx + 1)
        wins.InsertAt(btnx + 1, info)

        FileDelete(WinsInfoFileName)
        FileAppend(JSON.stringify(wins), WinsInfoFileName)
    }
}