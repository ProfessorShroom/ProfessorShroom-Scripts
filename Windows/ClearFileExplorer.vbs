On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Paths to clear
recentPath = shell.ExpandEnvironmentStrings("%APPDATA%\Microsoft\Windows\Recent\")
autoDestPath = recentPath & "AutomaticDestinations\"
customDestPath = recentPath & "CustomDestinations\"

' Delete Recent items
If fso.FolderExists(recentPath) Then
    fso.DeleteFile recentPath & "*", True
End If

' Remove address bar history
Const HKEY_CURRENT_USER = &H80000001
strKey = "Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths"

Set objReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
objReg.DeleteKey HKEY_CURRENT_USER, strKey

' Remove Quick Access Ribbon data
shell.RegDelete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon\"