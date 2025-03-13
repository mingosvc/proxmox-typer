#Requires AutoHotkey v2.0
#SingleInstance Force

; Global variable to store the macro text
MacroText := ""

; Main GUI for storing macro text
ShowMacroInputGui() 
{
    MacroGui := Gui()
    MacroGui.Opt("+AlwaysOnTop")
    MacroGui.Title := "Macro Text Input"
    
    MacroGui.Add("Text", "w300", "Enter the text to store in the macro:")
    
    ; Multi-line edit control
    TextInput := MacroGui.Add("Edit", "w600 h300 vMacroTextInput Multi VScroll")
    
    ; Load the content of the previous macro if it exists.
    global MacroText
    if (MacroText != "") 
        {
            TextInput.Value := MacroText
        }
    else if (A_Clipboard != "") 
        {
            TextInput.Value := A_Clipboard
        }
    
    ; Button to clear the text area
    ClearBtn := MacroGui.Add("Button", "w190 h50", "Clear Text")
    ClearBtn.OnEvent("Click", ClearTextHandler)
    
    ; Big buttons with height 30 and width 200
    SaveMacro := MacroGui.Add("Button", "w195 h50 x+10", "Save Macro")
    SaveMacro.OnEvent("Click", SaveMacroHandler)
    
    CancelBtn := MacroGui.Add("Button", "w195 h50 x+10", "Cancel")
    CancelBtn.OnEvent("Click", (*) => MacroGui.Destroy())
    
    ; Handler to close window
    MacroGui.OnEvent("Close", (*) => MacroGui.Destroy())
    
    ; Create specific hotkeys for this window
    HotIfWinActive("ahk_id " MacroGui.Hwnd)
    Hotkey("^Enter", SaveMacroHandler)
    Hotkey("Escape", (*) => MacroGui.Destroy())
    
    ClearTextHandler(*) 
    {
        TextInput.Value := ""  ; Clear text
        TextInput.Focus()      ; Set focus in text area
    }
    
    SaveMacroHandler(*) 
    {
        global MacroText
        MacroText := TextInput.Value
        if (MacroText != "") 
            {
                MacroGui.Destroy()
            } 
        else 
            {
                MacroGui.Destroy()
            }
    }
    
    MacroGui.Show()
}

; Hotkey to trigger macro text input (Ctrl+Shift+M)
^+m::ShowMacroInputGui()

; Hotkey to type stored macro text (Ctrl+Shift+V)
^+v::TypeMacroText()

TypeMacroText() {
    global MacroText
    if (MacroText != "") 
        {
            SendText(MacroText)
        } 
    else 
        {
            MsgBox("No macro text has been stored yet. Use Ctrl+Shift+M to set a macro.", "No Macro")
        }
}

; Persistent tray menu
A_IconTip := "Text Macro Script"
A_TrayMenu.Add("Set Macro Text (Ctrl+Shift+M)", (*) => ShowMacroInputGui())
A_TrayMenu.Add("Type Macro Text (Ctrl+Shift+V)", (*) => TypeMacroText())
