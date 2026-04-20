Set objShell = CreateObject("Wscript.Shell")
objShell.Run "powershell.exe -NoProfile -Command Clear-RecycleBin -Force", 0, True
