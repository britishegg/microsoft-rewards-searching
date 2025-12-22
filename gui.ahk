#Requires AutoHotkey v2.0
#SingleInstance Force

settingsGui := Gui('+AlwaysOnTop +Border -MaximizeBox -MinimizeBox +Caption', "Settings")
settingsGui.SetFont(, "Segoe UI")
settingsGui.Title := "Settings (Stopped)"

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
maxTypeSpeedGui := settingsGui.Add("UpDown", "Range0-250", 125)
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
minTypeSpeedGui := settingsGui.Add("UpDown", "Range0-250", 100)
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
maxTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range0-30000", 5250)
maxTimeBetweenSearchesGuiEdit.OnEvent("Change", update_maxtbs)
maxTimeBetweenSearchesGui.OnEvent("Change", update_maxtbs)
update_maxtbs(ctrl, *) {
    global maxTimeBetween

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 30000)
        if (clampValue == 0) OR (clampValue == 30000) {
            maxTimeBetweenSearchesGuiEdit.Value := clampValue
        }
        maxTimeBetween := clampValue
    }
}

settingsGui.Add("Text", "x115 y55", "Min Time Between Searches")
minTimeBetweenSearchesGuiEdit := settingsGui.Add("Edit", , "00000000000")
minTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range0-30000", 4750)
minTimeBetweenSearchesGuiEdit.OnEvent("Change", update_mintbs)
minTimeBetweenSearchesGui.OnEvent("Change", update_mintbs)
update_mintbs(ctrl, *) {
    global minTimeBetween

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 30000)
        if (clampValue == 0) OR (clampValue == 30000) {
            minTimeBetweenSearchesGuiEdit.Value := clampValue
        }
        minTimeBetween := clampValue
    }
}

; chances
settingsGui.Add("Text", "x268 y10", "Chance Of Typo")
typoChanceGuiEdit := settingsGui.Add("Edit", , "00000000000")
typoChanceGui := settingsGui.Add("UpDown", "Range0-100", 4)
typoChanceGuiEdit.OnEvent("Change", update_chancetypo)
typoChanceGui.OnEvent("Change", update_chancetypo)
update_chancetypo(ctrl, *) {
    global chanceOfTypo

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            typoChanceGuiEdit.Value := clampValue
        }
        chanceOfTypo := clampValue
    }
}

settingsGui.Add("Text", "x268 y55", "Chance Of StrSplit")
commaChanceGuiEdit := settingsGui.Add("Edit", , "00000000000")
commaChanceGui := settingsGui.Add("UpDown", "Range0-100", 80)
commaChanceGuiEdit.OnEvent("Change", update_chancecomma)
commaChanceGui.OnEvent("Change", update_chancecomma)
update_chancecomma(ctrl, *) {
    global chanceOfComma

    if IsInteger(ctrl.Value) {
        clampValue := clamp(ctrl.Value, 0, 100)
        if (clampValue == 0) OR (clampValue == 100) {
            commaChanceGuiEdit.Value := clampValue
        }
        chanceOfComma := clampValue
    }
}

; extras
settingsGui.SetFont("s9 bold", "Segoe UI")
settingsGui.Add("Text", , "Hotkey : F12")

settingsGui.SetFont("s7 italic", "Segoe UI")
settingsGui.Add("Text", "x10 y101", "note max and mins are in ms / the chances are in percentage")

settingsGui.OnEvent("Close", guiClose)
settingsGui.Show("w373 h121 Center")