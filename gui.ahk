#Requires AutoHotkey v2.0
#SingleInstance Force

settingsGui := Gui('+AlwaysOnTop +Border -MaximizeBox -MinimizeBox +Caption', "Settings")
settingsGui.SetFont(, "Segoe UI")
settingsGui.Title := "Settings"

; max type speed
settingsGui.Add("Text", "x10 y10", "Max Type Delay")
settingsGui.Add("Edit", , "00000000000")
maxTypeSpeedGui := settingsGui.Add("UpDown", "Range50-150", 125)
maxTypeSpeedGui.OnEvent("Change", update_maxts)
update_maxts(ctrl, *) {
    global maxTimeBetweenTypeSegments
    maxTimeBetweenTypeSegments := ctrl.Value
}

; min type speed
settingsGui.Add("Text", "x10 y55", "Min Type Delay")
settingsGui.Add("Edit", , "00000000000")
minTypeSpeedGui := settingsGui.Add("UpDown", "Range50-150", 100)
minTypeSpeedGui.OnEvent("Change", update_mints)
update_mints(ctrl, *) {
    global minTimeBetweenTypeSegments
    minTimeBetweenTypeSegments := ctrl.Value
}

; max time between searches
settingsGui.Add("Text", "x115 y10", "Max Time Between Searches")
settingsGui.Add("Edit", , "00000000000")
maxTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range4000-6000", 5250)
maxTimeBetweenSearchesGui.OnEvent("Change", update_maxtbs)
update_maxtbs(ctrl, *) {
    global maxTimeBetween
    maxTimeBetween := ctrl.Value
}

; min time between searches
settingsGui.Add("Text", "x115 y55", "Min Time Between Searches")
settingsGui.Add("Edit", , "00000000000")
minTimeBetweenSearchesGui := settingsGui.Add("UpDown", "Range4000-6000", 4750)
minTimeBetweenSearchesGui.OnEvent("Change", update_mintbs)
update_mintbs(ctrl, *) {
    global minTimeBetween
    minTimeBetween := ctrl.Value
}

; typochance
settingsGui.Add("Text", "x268 y10", "Chance Of Typo")
settingsGui.Add("Edit", , "00000000000")
typoChance := settingsGui.Add("UpDown", "Range0-100", 4)
typoChance.OnEvent("Change", update_chancetypo)
update_chancetypo(ctrl, *) {
    global chanceOfTypo
    chanceOfTypo := ctrl.Value
}

; comma chance
settingsGui.Add("Text", "x268 y55", "Chance Of StrSplit")
settingsGui.Add("Edit", , "00000000000")
commaChance := settingsGui.Add("UpDown", "Range0-100", 80)
commaChance.OnEvent("Change", update_chancecomma)
update_chancecomma(ctrl, *) {
    global chanceOfComma
    chanceOfComma := ctrl.Value
}

; hotkey
settingsGui.SetFont("bold", "Segoe UI")
settingsGui.Add("Text", , "Hotkey : F12")

; note
settingsGui.SetFont("s7 italic", "Segoe UI")
settingsGui.Add("Text", "x10 y101", "note max and mins are in ms / the chances are in percentage")

guiClose(*) {
    ExitApp()
}

settingsGui.OnEvent("Close", guiClose)
settingsGui.Show("w373 h121 Center")