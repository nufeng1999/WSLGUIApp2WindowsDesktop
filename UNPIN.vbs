Dim strFolder, strExecutable

strFolder = Wscript.Arguments.Named("folder")
strExecutable = Wscript.Arguments.Named("file")

Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.Namespace(strFolder)
Set objFolderItem = objFolder.ParseName(strExecutable)

'Collect Applications verbs
Set colVerbs = objFolderItem.Verbs

'Loop through the verbs and if UNPIN is found then 'DoIt' (execute)
blnOptionFound = False
For Each objVerb In colVerbs
   If Replace(objVerb.name, "&", "") = "Unpin from Start" Then
      objVerb.DoIt
      blnOptionFound = True
      WScript.Echo "The application '" & strExecutable & "' was just Unpinned from the Start Menu."
   End If
Next

if blnOptionFound = false then
   WScript.Echo "The application '" & strExecutable & "' failed to be unpinned from the Start Menu (may not be present)."
end if