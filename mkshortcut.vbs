set WshShell = WScript.CreateObject("WScript.Shell" )

Rem set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")
set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")

oShellLink.TargetPath = Wscript.Arguments.Named("target")
oShellLink.Arguments = Wscript.Arguments.Named("arguments")
oShellLink.IconLocation = Wscript.Arguments.Named("icon")
oShellLink.Description = Wscript.Arguments.Named("description")
oShellLink.WorkingDirectory = Wscript.Arguments.Named("workdir")
oShellLink.WindowStyle = 1
oShellLink.Save