global winsInfo := {}

bindWinsInit()
{
    global winsInfo
    global tapTimes:={1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0,19:0,20:0,btn:-1}
    global winTapedX ;winTapedX用于判断多窗口绑定的切换是哪个按键的，在CapsLock松开后winsSort()用来判定一次窗口在窗口组的位置
    global lastActiveWinId ;在用窗口激活时，现在正在激活状态的窗口id
    ;标志有没获取过窗口信息，因为判断多次敲击需要等待时间，
    ;超时了才执行绑定程序，在等待时间中唤醒绑定窗口会造成绑定失败，
    ;所以增加一个标志，当唤醒窗口时，标志不假则立刻执行一次绑定程序
    global gettingWinInfo:=0

    IfNotExist("winsInfo.ini")
    {
        FileAppend(%winsInfoInit%, winsInfo.ini, UTF-16)
    }
    winsInfoInit:=""

    IniRead(infosSections, winsInfo.ini, , , %A_Space%)
    sectionArr:=StrSplit(infosSections,"`n")
    loop, % tapTimes.MaxIndex() ;+1：把索引从0开始换成1开始
        initWinsInfos(A_index)
    ;  {
    ;  		_t:="group" . A_index-1 ;-1：把索引从1开始换成0开始
    ;      winsInfos[_t]:={}
    ;      winsInfos[_t].class:={}
    ;      winsInfos[_t].exe:={}
    ;      winsInfos[_t].id:={}
    ;  }
    ;取出winsInfosRecorder.ini里的数据，数组存着
    for sectionKey,sectionValue in sectionArr
    {
        ;~ winsInfos[sectionValue].length:=0
        IniRead, infosKeys, winsInfo.ini, %sectionValue%, , %A_Space%
        infosKeys:=RegExReplace(infosKeys, "m`n)=.*$")
        keyArr:=StrSplit(infosKeys,"`n")
        for key,keyValue in keyArr
        {
            IniRead, infos, winsInfo.ini, %sectionValue%, %keyValue%, %A_Space%
            if(keyValue="bindType") ;如果是bindType则直接记录，否则是class,exe,id，再开多一维数组记录
            {
                winsInfos[sectionValue].bindType:=infos
            }
            else
            {
                ni:=StrSplit(keyValue, "_") ;name and id
                winsInfos[sectionValue][ni.1][ni.2]:=infos
            }
        }
    }
}

bindWinsInit()