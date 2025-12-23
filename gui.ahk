#Requires AutoHotkey v2.0
#SingleInstance Force

typoChance := 4
commaChance := 80

maxTimeBetweenTypeSegments := 125
minTimeBetweenTypeSegments := 100

maxTimeBetweenSearches := 5250
minTimeBetweenSearches := 4750

timeBeforeClear := 2000
timeBeforeSearching := 250

settingsGui := Gui('+AlwaysOnTop +Border -MaximizeBox -MinimizeBox +Caption', "Settings")
settingsGui.SetFont(, "Segoe UI")

guiClose(*) {
    ExitApp()
}

clamp(value, min, max) {
    if (value < min)
        return min
    else if (value > max)
        return max
    else
        return value
}

;type speed
settingsGui.Add("Text", "x10 y10", "Max Type Delay")
maxTypeSpeedGuiEdit := settingsGui.Add("Edit", , "00000000000")
maxTypeSpeedGui := settingsGui.Add("UpDown", "Range0-250", maxTimeBetweenTypeSegments)
maxTypeSpeedGuiEdit.OnEvent("Change", update_maxts)
maxTypeSpeedGui.OnEvent("Change", update_maxts)
update_maxts(ctrl, *) {
    global maxTimeBetweenTypeSegments

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 250)
        if (clampValue == 0) OR (clampValue == 250) {
            maxTypeSpeedGuiEdit.Value := clampValue
        }
        maxTimeBetweenTypeSegments := clampValue
    }
}

settingsGui.Add("Text", "x10 y55", "Min Type Delay")
minTypeSpeedGuiEdit := settingsGui.Add("Edit", , "00000000000")
minTypeSpeedGui := settingsGui.Add("UpDown", "Range0-250", minTimeBetweenTypeSegments)
minTypeSpeedGuiEdit.OnEvent("Change", update_mints)
minTypeSpeedGui.OnEvent("Change", update_mints)
update_mints(ctrl, *) {
    global minTimeBetweenTypeSegments

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 250)
        if (clampValue == 0) OR (clampValue == 250) {
            minTypeSpeedGuiEdit.Value := clampValue
        }
        minTimeBetweenTypeSegments := clampValue
    }
}

; time between searches
settingsGui.Add("Text", "x115 y10", "Max Time Between Searches")
maxTimeBetweenSearchesGuiEdit := settingsGui.Add("Edit", , "00000000000")
maxTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range0-30000", maxTimeBetweenSearches)
maxTimeBetweenSearchesGuiEdit.OnEvent("Change", update_maxtbs)
maxTimeBetweenSearchesGui.OnEvent("Change", update_maxtbs)
update_maxtbs(ctrl, *) {
    global maxTimeBetweenSearches

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 30000)
        if (clampValue == 0) OR (clampValue == 30000) {
            maxTimeBetweenSearchesGuiEdit.Value := clampValue
        }
        maxTimeBetweenSearches := clampValue
    }
}

settingsGui.Add("Text", "x115 y55", "Min Time Between Searches")
minTimeBetweenSearchesGuiEdit := settingsGui.Add("Edit", , "00000000000")
minTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range0-30000", minTimeBetweenSearches)
minTimeBetweenSearchesGuiEdit.OnEvent("Change", update_mintbs)
minTimeBetweenSearchesGui.OnEvent("Change", update_mintbs)
update_mintbs(ctrl, *) {
    global minTimeBetweenSearches

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 30000)
        if (clampValue == 0) OR (clampValue == 30000) {
            minTimeBetweenSearchesGuiEdit.Value := clampValue
        }
        minTimeBetweenSearches := clampValue
    }
}

; chances
settingsGui.Add("Text", "x268 y10", "Chance Of Typo")
typoChanceGuiEdit := settingsGui.Add("Edit", , "00000000000")
typoChanceGui := settingsGui.Add("UpDown", "Range0-100", typoChance)
typoChanceGuiEdit.OnEvent("Change", update_chancetypo)
typoChanceGui.OnEvent("Change", update_chancetypo)
update_chancetypo(ctrl, *) {
    global typoChance

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            typoChanceGuiEdit.Value := clampValue
        }
        typoChance := clampValue
    }
}

settingsGui.Add("Text", "x268 y55", "Chance Of StrSplit")
commaChanceGuiEdit := settingsGui.Add("Edit", , "00000000000")
commaChanceGui := settingsGui.Add("UpDown", "Range0-100", commaChance)
commaChanceGuiEdit.OnEvent("Change", update_chancecomma)
commaChanceGui.OnEvent("Change", update_chancecomma)
update_chancecomma(ctrl, *) {
    global commaChance

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            commaChanceGuiEdit.Value := clampValue
        }
        commaChance := clampValue
    }
}

; time before clearing / searching
settingsGui.Add("Text", "x10", "Time Before Clear")
timeClearGuiEdit := settingsGui.Add("Edit", , "00000000000")
timeClearGui := settingsGui.Add("UpDown", "Range0-5000", timeBeforeClear)
timeClearGuiEdit.OnEvent("Change", update_clear)
timeClearGui.OnEvent("Change", update_clear)
update_clear(ctrl, *) {
    global timeBeforeClear

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            timeClearGuiEdit.Value := clampValue
        }
        timeBeforeClear := clampValue
    }
}

settingsGui.Add("Text", "x10", "Time Before Search")
timeBeforeSearchingGuiEdit := settingsGui.Add("Edit", , "00000000000")
timeBeforeSearchingGui := settingsGui.Add("UpDown", "Range0-1000", timeBeforeSearching)
timeBeforeSearchingGuiEdit.OnEvent("Change", update_before_search)
timeBeforeSearchingGui.OnEvent("Change", update_before_search)
update_before_search(ctrl, *) {
    global timeBeforeSearching

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            timeBeforeSearchingGuiEdit.Value := clampValue
        }
        timeBeforeSearching := clampValue
    }
}

; ai gui stuff
settingsGui.SetFont("s13")
aiGuiCheckBox := settingsGui.Add("Checkbox", "x115 y100 +Checked", "Use AI?")
aiGuiCheckBox.OnEvent("Click", set_ai_mode)
set_ai_mode(ctrl, *) {
    global ai := ctrl.Value
}

settingsGui.SetFont("s12")
modelGuiDDL := settingsGui.Add("DropDownList", "w250", ["gpt-oss:20b-cloud", "gemini-3-flash-preview:cloud", "nemotron-3-nano:30b-cloud"])
modelGuiDDL.Value := 1
modelGuiDDL.OnEvent("Change", change_model)
change_model(ctrl, *) {
    global model := ctrl.Text
}

; extras
settingsGui.SetFont("s11 bold", "Segoe UI")
settingsGui.Add("Text", "x114 y165", "Hotkey : F12")

settingsGui.SetFont()
settingsGui.SetFont("s10 c009300", "Segoe UI")
statusGui := settingsGui.Add("Text", "x208 y167", "00000000000000000000")

set_status(status) {
    settingsGui.Title := "Settings (" . status . ")"    
    statusGui.Value := status
    if status == "Stopped" {
        statusGui.SetFont("c940000")
    } else if status == "Typing" {
        statusGui.SetFont("c600060")
    } else if InStr(status, "Waiting") > 0 {
        statusGui.SetFont("cba8500")
    }
}

set_status("Stopped")

settingsGui.SetFont("s8 italic cBlack", "Segoe UI")
settingsGui.Add("Text", "x10 y192", "note max and mins are in milliseconds the chances are in percentage")

settingsGui.OnEvent("Close", guiClose)
settingsGui.Show("w373 h213 Center")