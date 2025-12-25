#Requires AutoHotkey v2.0
#SingleInstance Force

if FileExist("JSON.ahk") {
    #Include JSON.ahk
}
#Include gui.ahk
#Include constants.ahk

if !checkForInternet() {
    ai := false
    aiGuiCheckBox.Value := 0
    aiGuiCheckBox.Enabled := false
    MsgBox("No internet can't use AI", "No Internet", "0x1000 Icon!")
}

checkForInternet() {
    try {
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", "https://www.google.com", true)
        http.Send()
        http.WaitForResponse(1000)
        return true
    } catch {
        return false
    }
}

sendPrompt(prompt) {
    statusGui.SetFont("c32c800")
    setStatus("Generating")

    url := "http://localhost:11434/api/generate"
    http := ComObject("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", url, false)
    http.SetRequestHeader("Content-Type", "application/json")

    body := (
        '{'
            '"model":"' model '",'
            '"prompt":"' StrReplace(prompt, '"', '\"') '",'
            '"stream":false'
        '}'
    )

    http.Send(body)
    parsed := JSON.Load(http.ResponseText)
    return parsed["response"]
}

createCommasInString(str, commaChance, typoChance) {
    finalStr := ""
    chars := StrSplit(str)
    typoIndex := 1

    for i, char in chars {
        if Random(1, 100) <= typoChance {
            if typoMapping.Has(char) {
                typoIndex := Random(1, typoMapping[char].Length)
                finalStr .= typoMapping[char][typoIndex]
            }
        } else {
            finalStr .= char
        }

        if Random(1, 100) <= commaChance {
            finalStr .= ","
        }
    }

    return finalStr
}

typeOut() {
    global timeBetweenTypeSegments

    setStatus("Typing")

    if ai {
        phrase := sendPrompt(aiPrompt)
    } else {
        randomPhrase := Random(1, phraseList.Length)
        phrase := phraseList[randomPhrase]
    }
    sendSplit := StrSplit(createCommasInString(phrase, commaChance, typoChance), ",")
    for i, part in sendSplit {
        if macroing {
            timeBetweenTypeSegments := Random(minTimeBetweenTypeSegments, maxTimeBetweenTypeSegments)
            Send(part)
            Sleep(timeBetweenTypeSegments)
        }
    }
}

clearText() {
    global timeBetweenSearches := Random(minTimeBetweenSearches, maxTimeBetweenSearches)

    if macroing {
        Send("/")
        Sleep(50)
        Send("^a")
        Sleep(50)
        Send("{Delete}")
        setStatus("Waiting " . Round(timeBetweenSearches / 1000, 1) . "s")
        SetTimer(sendAndClear, -timeBetweenSearches)
    }
}

sendAndClear() {
    if macroing {
        typeOut()
        Sleep(timeBeforeSearching)
        Send("{Enter}")
        Sleep(timeBeforeClear)
        clearText()
    }
}

toggleMacro(*) {
    global macroing
    macroing := !macroing

    if macroing {
        sendAndClear()
    } else {
        setStatus("Stopped")
    }
}

updateHotkey() {
    Hotkey(mainHotkey, toggleMacro)
    ToolTip mainHotkey
}

SetTimer(updateHotkey, 1)