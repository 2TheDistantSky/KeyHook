language_English:
; lib\lib_bindWins.ahk
global lang_bw_noWIRini:="winsInfo.ini does not exist"

; clq.ahk
global lang_clq_addIni:="Are you sure to abbreviate the following string to {replace0} and record to {replace1}?"
global lang_clq_existing:="{replace0} `n already exists in {replace1}. Are you sure to overwrite with the following settings?"
global lang_clq_qrunFileNotExist:="The following records exist in QRun, but the corresponding file (folder) does not exist. Do you want to delete this setting?"
global lang_clq_noCmd:="No such command"
global lang_clq_emptyFolder:="<Empty folder>"

; ydTrans.ahk
global lang_yd_translating:="Translating... (If the network is too bad, the translation request will temporarily block the program, just wait a moment)"
global lang_yd_name:="Youdao Translation"
global lang_yd_needKey:="Youdao translator cannot be used without the key of Youdao translation API"
global lang_yd_fileNotExist:="File (folder) does not exist"
global lang_yd_errorNoNet:="Failed to send, maybe the network is disconnected"
global lang_yd_errorTooLong:="Some sentences are too long"
global lang_yd_errorNoResults:="No result"
global lang_yd_errorTextTooLong:="The text to be translated is too long"
global lang_yd_errorCantTrans:="Unable to translate"
global lang_yd_errorLangType:="Unsupported language type"
global lang_yd_errorKeyInvalid:="Invalid key"
global lang_yd_errorSpendingLimit:="Reached today's consumption limit, or the length of the request exceeds the number of characters that can be consumed today"
global lang_yd_errorNoFunds:="Insufficient account balance"
global lang_yd_trans:=  "------------------------------ Youdao Translation -----------------------------"
global lang_yd_dict:=   "------------------------------ Youdao dictionary ------------------------------"
global lang_yd_phrase:= "----------------------------------- Phrase ------------------------------------"

global lang_settingsFileContent:=""
lang_settingsFileContent=
(
;------------ Encoding: UTF-16 ------------
; Please refer to CapsLock+settingsDemo.ini to configure settings
[Global]

loadScript=scriptDemo.js

[QSearch]

[QRun]

[QWeb]

[TabHotString]

[QStyle]

[TTranslate]

[Keys]

)

global lang_winsInfosRecorderIniInit:=""
lang_winsInfosRecorderIniInit=
(
;------------ Encoding: UTF-16 ------------
; The data for Window Binding, DO NOT modify the content of this file!
; Just click the "X" in the upper right.

[0]
bindType=
class_0=
exe_0=
id_0=
[1]
bindType=
class_0=
exe_0=
id_0=
[2]
bindType=
class_0=
exe_0=
id_0=
[3]
bindType=
class_0=
exe_0=
id_0=
[4]
bindType=
class_0=
exe_0=
id_0=
[5]
bindType=
class_0=
exe_0=
id_0=
[6]
bindType=
class_0=
exe_0=
id_0=
[7]
bindType=
class_0=
exe_0=
id_0=
[8]
bindType=
class_0=
exe_0=
id_0=
)

; keysFunction.ahk
global lang_kf_getDebugText:=""
lang_kf_getDebugText=
(
The string for debug TabScript
Click "OK" to copy it to the clipboard.
)
return
