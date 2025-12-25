#Requires AutoHotkey v2.0
#SingleInstance Force

#Include constants.ahk

settingsGui := Gui('+AlwaysOnTop +Border -MaximizeBox -MinimizeBox +Caption', "Settings")
settingsGui.SetFont(, "Segoe UI")

clamp(value, min, max) {
    if (value < min) {
        return min
    } else if (value > max) {
        return max
    } else {
        return value
    }
}

; all of the UDs
bindUDandEdit(ctrl, edit, varRef, min, max) {
    edit.OnEvent("Change", (*) => setVariableWithEdit(ctrl, edit, &varRef, min, max))
}

setVariableWithEdit(ctrl, edit, &varRef, min, max) {
    if InStr(edit.Value, ",") {
        edit.Value := StrReplace(edit.Value, ",", "")
    }

    if !IsInteger(ctrl.Value) {
        return
    }

    value := clamp(ctrl.Value, min, max)
    if (value = min OR value = max) {
        edit.Value := value
    }
    varRef := value
}

for i in guiSettingsUD {
    settingsGui.Add("Text", i.x . A_Space . i.y, i.name)

    guiEdit := settingsGui.AddEdit( , "00000000000")
    guiUD := settingsGui.AddUpDown("Range" . i.min . "-" . i.max, i.var)
    guiEdit.Value := StrReplace(guiEdit.Value, ",", "")

    bindUDAndEdit(guiUD, guiEdit, i.var, i.min, i.max)
}

; ai gui
settingsGui.SetFont("s13")
aiGuiCheckBox := settingsGui.AddCheckbox("x115 y101 +Checked", "Use AI?")
aiGuiCheckBox.OnEvent("Click", (ctrl, *) => ai := ctrl.Value)

settingsGui.SetFont("s12")
modelGuiDDL := settingsGui.AddDDL("x115 y130 w250", aiModels)
modelGuiDDL.Value := 1
modelGuiDDL.OnEvent("Change", (ctrl, *) => model := ctrl.Text)

settingsGui.SetFont("s10")
updateGuiButton := settingsGui.AddButton("x195 y99 w170 h28", "Update Model List")
updateGuiButton.OnEvent("Click", (*) => updateOllamaModels())

updateOllamaModels(*) {
    settingsGui.Hide()
    ollamaExeFile := EnvGet("LOCALAPPDATA") . "\Programs\Ollama\ollama.exe"

    if !FileExist(ollamaExeFile) {
        MsgBox("Couldn't find Ollama make sure you have it installed and Ollama.exe is at the directory :" . '"C:\Users\<User>\AppData\Local\Programs\Ollama".', "Missing Ollama", "0x1000 Icon!")
        return
    }

    global aiModels := []
    global modelGuiDDL

    shell := ComObject("WScript.Shell")
    exec := shell.Exec('"' . ollamaExeFile . '" list')
    for i in StrSplit(exec.StdOut.ReadAll(), "`n", "`r") {
        i := Trim(i)

        if (i = "" OR InStr(i, "NAME")) {
            continue
        }

        name := StrSplit(i, A_Space, , 2)[1]
        aiModels.Push(name)
    }
    settingsGui.Show()
    modelGuiDDL.Delete()
    modelGuiDDL.Add(aiModels)
    modelGuiDDL.Value := 1
}

; extra
settingsGui.SetFont("s11 bold", "Segoe UI")
settingsGui.Add("Text", "x114 y165", "Hotkey : ")

settingsGui.SetFont()
settingsGui.SetFont("s10", "Segoe UI")
hotkeyGuiDDL := settingsGui.Add("DropDownList", "x177 y164 w43", hotkeys)
hotkeyGuiDDL.Value := 12
hotkeyGuiDDL.OnEvent("Change", switchHotkey)
switchHotkey(ctrl, *) {
    global mainHotkey := ctrl.Text
}

settingsGui.SetFont()
settingsGui.SetFont("s10", "Segoe UI")
statusGui := settingsGui.Add("Text", "x225 y167", "00000000000000000000")

setStatus(status) {
    settingsGui.Title := "Settings (" . status . ")"    
    statusGui.Value := status
    if status == "Stopped" {
        statusGui.SetFont("c940000")
    } else if status == "Typing" {
        statusGui.SetFont("c600060")
    } else if InStr(status, "Waiting") {
        statusGui.SetFont("cba8500")
    }
}

setStatus("Stopped")

settingsGui.SetFont("s8 italic cBlack", "Segoe UI")
settingsGui.Add("Text", "x10 y192", "note max and mins are in milliseconds the chances are in percentage")

settingsGui.OnEvent("Close", (*) => ExitApp())
settingsGui.Show("w373 h213 Center")