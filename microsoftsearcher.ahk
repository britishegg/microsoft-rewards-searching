#Requires AutoHotkey v2.0
#SingleInstance Force

#Include PhraseList.ahk 

timeBeforeClear := 2500
timeBetween := 10000
macroing := false

type_out() {
    randomPhrase := Random(1, phraseList.Length)
    sendSplit := StrSplit(phraseList[randomPhrase], ",")
    for i, part in sendSplit {
        Send(part)
        Sleep(100)
    }
    Send("?")
}

clear_text() {
    Send("/")
    Sleep(500)
    Send("^a")
    Sleep(250)
    Send("{Delete}")
}

send_and_clear() {
    if macroing {
        type_out()
        Sleep(250)
        Send("{Enter}")
        Sleep(timeBeforeClear)
        clear_text()
    }
}

SetTimer(send_and_clear, timeBetween)

^B:: {
    global macroing
    macroing := !macroing

    MouseGetPos(&x, &y)
    if macroing {
        ToolTip("Auto-searching started", x + 15, y + 15)
        send_and_clear()
    } else {
        ToolTip("Auto-searching stopped", x + 15, y + 15)
    }

    SetTimer(ToolTip, 1500)
}