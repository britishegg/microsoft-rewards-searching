#Requires AutoHotkey v2.0
#SingleInstance Force

if FileExist("JSON.ahk") {
    #Include JSON.ahk
}
#Include gui.ahk
#Include constants.ahk

ai := true
model := "gpt-oss:20b-cloud"

macroing := false

timeBetweenTypeSegments := 0
timeBetweenSearches := 0

if !check_for_internet() {
    ai := false
    aiGuiCheckBox.Value := 0
    aiGuiCheckBox.Enabled := false
    MsgBox("No internet can't use AI", "No Internet", "0x1000 Icon!")
}

check_for_internet() {
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

send_prompt(prompt) {
    statusGui.SetFont("c32c800")
    set_status("Generating")

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
    set_status("Typing")
    parsed := JSON.Load(http.ResponseText)
    return parsed["response"]
}

create_commas_in_string(str, commaChance, typoChance) {
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
    global timeBetweenTypeSegments

    if ai {
        phrase := send_prompt(aiPrompt)
    } else {
        randomPhrase := Random(1, phraseList.Length)
        phrase := phraseList[randomPhrase]
    }
    sendSplit := StrSplit(create_commas_in_string(phrase, commaChance, typoChance), ",")
    for i, part in sendSplit {
        if macroing {
            timeBetweenTypeSegments := Random(minTimeBetweenTypeSegments, maxTimeBetweenTypeSegments)
            Send(part)
            Sleep(timeBetweenTypeSegments)
        }
    }
}

clear_text() {
    global timeBetweenSearches := Random(minTimeBetweenSearches, maxTimeBetweenSearches)

    if macroing {
        Send("/")
        Sleep(50)
        Send("^a")
        Sleep(50)
        Send("{Delete}")
        set_status("Waiting " . Round(timeBetweenSearches / 1000, 1) . "s")
        SetTimer(send_and_clear, -timeBetweenSearches)
    }
}

send_and_clear() {
    if macroing {
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
        send_and_clear()
    } else {
        set_status("Stopped")
    }
}