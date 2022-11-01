;等待其他文件的 include 完成
SetTimer, initAll, -400

Return

initAll:
    ; 挂起所有热键
    Suspend, On

    gosub, keysInit
    gosub, bindWinsInit
    ; 初始化翻译api
    setTimer, youdaoApiInit, -1

    Suspend, Off

Return
