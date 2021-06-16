Dim strFolder, strExecutable

strFolder = Wscript.Arguments.Named("folder")
strExecutable = Wscript.Arguments.Named("file")

strFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\WSLApps"
strExecutable ="glade.lnk"
Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.Namespace(strFolder)
Set objFolderItem = objFolder.ParseName(strExecutable)

Set colVerbs = objFolderItem.Verbs

'uncomment this section to display the available verbs
' For Each objVerb In colVerbs
'    If objVerb <> "" Then
'       WScript.Echo objVerb
'    End If
' Next

'Loop through the verbs and if PIN is found then 'DoIt' (execute)
blnOptionFound = False
For Each objVerb In colVerbs
'WScript.Echo objVerb.name
    If instr( objVerb.name , "¹Ì¶¨µ½" ) > 0 then
        objVerb.DoIt
        blnOptionFound = True
'      WScript.Echo "The application '" & strExecutable & "' was just Pinned to the Start Menu."
   End If
Next

'if blnOptionFound = false then
'   WScript.Echo "The application '" & strExecutable & "' failed to pin to the Start Menu (may already be present)."
'end if