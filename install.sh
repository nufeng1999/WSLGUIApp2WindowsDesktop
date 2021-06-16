#!/bin/bash
cd ./libshell
. shell-ini-config
cd ..
#create wslappicons dir
mkdir -p /mnt/c/PROGRA~1/wslapps/icons
mkdir -p /mnt/c/PROGRA~1/wslapps/shortcut
shortcutpath="C:\\PROGRA~1\\wslapps\\shortcut"
mkdir -p "/mnt/c/ProgramData/Microsoft/Windows/Start Menu/Programs/WSLApps"
startshortcutpath="C:\\ProgramData\\Microsoft\\Windows\\STARTM~1\\Programs\\WSLApps"
cp -f $PWD/icons/* /mnt/c/Progra~1/wslapps/icons

inifile="./apps.ini"
wintemp=`/mnt/c/WINDOWS/System32/cmd.exe /c "echo %TEMP%" 2>/dev/null|head -n 1 |tail -n 1`
#winwsltemp=${winwsltemp//$'\r'}
#winwsltemp=${winwsltemp//$'\n'}
wintemp=${wintemp//$'\r'}
wintemp=${wintemp//$'\n'}
winwsltemp=`wslpath -u $wintemp`
mkshortcutvbsfile=`echo $winwsltemp/mkshortcut.vbs`
cp $PWD/mkshortcut.vbs $mkshortcutvbsfile

appcout=$(ini_config_get "$inifile" "apps" "appcout")
echo "$appcout"
cnt1=1
#appcout=1
appcout=$(($appcout+1))
while [ $cnt1 -lt $appcout ]; do
    echo read $cnt1
    shortcut=$(ini_config_get "$inifile" "$cnt1" "shortcut")
    ishortcut="${shortcutpath}\\${shortcut}"
    startshortcut="${startshortcutpath}\\${shortcut}"
    target=$(ini_config_get "$inifile" "$cnt1" "target")
    icon=$(ini_config_get "$inifile" "$cnt1" "icon")
    description=$(ini_config_get "$inifile" "$cnt1" "description")
    workdir=$(ini_config_get "$inifile" "$cnt1" "workdir")
    arguments=$(ini_config_get "$inifile" "$cnt1" "arguments")

    cnt1=$(($cnt1+1))
    appshortcut="/shortcut:\"$ishortcut\" /target:\"$target\" /icon:\"$icon\" /description:\"$description\" /workdir:\"$workdir\" /arguments:\"$arguments\""
    startappshortcut="/shortcut:\"$startshortcut\" /target:\"$target\" /icon:\"$icon\" /description:\"$description\" /workdir:\"$workdir\" /arguments:\"$arguments\""
    /mnt/c/WINDOWS/System32/ScriptRunner.exe  -appvscript $wintemp\\mkshortcut.vbs $appshortcut
    /mnt/c/WINDOWS/System32/ScriptRunner.exe  -appvscript $wintemp\\mkshortcut.vbs $startappshortcut
done
