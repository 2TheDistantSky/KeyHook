;~ 初始化段，也就是自动运行段，所有需要自动运行的代码放这里，然后放到程序最开头
SetTimer, initAll, -400 ;等个100毫秒，等待其他文件的include都完成

return

initAll:
    ; 挂起所有热键
    Suspend, On

    ; language
    gosub, language_English

    ; 初始化设置
    gosub, settingsInit

    gosub, bindWinsInit
    ; 初始化翻译api
    setTimer, youdaoApiInit, -1
    ; +q初始化标志位
    global needInitQ:=1
    ; 初始化+q
    CLq()

    Suspend, Off

return
