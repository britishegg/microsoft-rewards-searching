#Requires AutoHotkey v2.0
#SingleInstance Force

#Include PhraseList.ahk 

macroing := false

timeBeforeClear := 0
timeBetweenTypeSegments := 150
timeBeforeSearching := 250

maxTimeBetween := 5250
minTimeBetween := 4750
timeBetween := 1

type_out() {
    global phraseList
    global timeBetweenTypeSegments

    randomPhrase := Random(1, phraseList.Length)
    sendSplit := StrSplit(phraseList[randomPhrase], ",")
    for i, part in sendSplit {
        if macroing {
            Send(part)
            Sleep(timeBetweenTypeSegments)
        }
    }
    Send("?")
}

clear_text() {
    global macroing

    if macroing {
        Send("/")
        Sleep(50)
        Send("^a")
        Sleep(50)
        Send("{Delete}")
        SetTimer(send_and_clear, -timeBetween)
    }
}

send_and_clear() {
    global macroing
    global timeBeforeSearching
    global timeBeforeClear
    global maxTimeBetween
    global minTimeBetween
    global timeBetween

    if macroing {
        timeBetween := Random(minTimeBetween, maxTimeBetween)
        timeBeforeClear := timeBetween * 0.5

        type_out()
        Sleep(timeBeforeSearching)
        Send("{Enter}")
        Sleep(timeBeforeClear)
        clear_text()
    }
}


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

    SetTimer(ToolTip, -1500)
}