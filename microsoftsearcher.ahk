#Requires AutoHotkey v2.0
#SingleInstance Force

#Include lists.ahk 
#Include gui.ahk

macroing := false

chanceOfComma := 80
chanceOfTypo := 4

timeBeforeClear := 0
timeBeforeSearching := 250

maxTimeBetweenTypeSegments := 125
minTimeBetweenTypeSegments := 100
timeBetweenTypeSegments := 0

maxTimeBetween := 5250
minTimeBetween := 4750
timeBetween := 0

create_commas_in_string(str, commaChance, typoChance) {
    global typoList

    finalStr := ""
    chars := StrSplit(str)
    typoIndex := 1

    for i, char in chars {
        if Random(1, 100) <= typoChance {
            typoIndex := Random(1, typoList.Length)
            finalStr .= typoList[typoIndex]
        } else {
            finalStr .= char
        }

        if Random(1, 100) <= commaChance {
            finalStr .= ","
        }
    }

    return finalStr
}

type_out() {
    global phraseList
    global chanceOfComma
    global chanceOfTypo
    global maxTimeBetweenTypeSegments
    global minTimeBetweenTypeSegments
    global timeBetweenTypeSegments

    randomPhrase := Random(1, phraseList.Length)
    sendSplit := StrSplit(create_commas_in_string(phraseList[randomPhrase], chanceOfComma, chanceOfTypo), ",")
    for i, part in sendSplit {
        if macroing {
            timeBetweenTypeSegments := Random(minTimeBetweenTypeSegments, maxTimeBetweenTypeSegments)
            Send(part)
            Sleep(timeBetweenTypeSegments)
        }
    }

    punctuationType := Random(1, 2)

    if punctuationType == 1 {
        Send("?")
    } else {
        Send("")
    }
}

clear_text() {
    global macroing
    global timeBetween

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

F12:: {
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