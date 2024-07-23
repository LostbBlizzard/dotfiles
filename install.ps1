$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

function RemoveFileIfExst($filePath) {
    
    if (Test-Path $filePath) {
        Remove-Item -Path $filePath 
    }

}
# apps
# GlazeWM
winget install GlazeWM
# GlazeWM

# lazydocker
go install github.com/jesseduffield/lazydocker@latest
# lazydocker
 app

# Vim Settings
RemoveFileIfExst $env:USERPROFILE\.vimrc
cmd /c mklink $env:USERPROFILE\.vimrc $dir\.vimrc
cmd /c mklink $env:USERPROFILE\.vifm\vifmrc $dir\config\vifm\vifmrc
cmd /c mklink /D $env:USERPROFILE\AppData\Local\nvim $dir\config\nvim

# VS Code Settings
RemoveFileIfExst $env:APPDATA\Code\User\settings.json 
RemoveFileIfExst $env:APPDATA\Code\User\keybindings.json 

cmd /c mklink $env:APPDATA\Code\User\settings.json $dir\config\Code\User\settings.json 
cmd /c mklink $env:APPDATA\Code\User\keybindings.json $dir\config\Code\User\keybindings.json 

RemoveFileIfExst $env:USERPROFILE\.kanata\config.kdb
RemoveFileIfExst $env:USERPROFILE\.glaze-wm\config.yaml

cmd /c mklink $env:USERPROFILE\.kanata\config.kdb $dir\config\kanata\config.kdb

cmd /c mklink $env:USERPROFILE\.glaze-wm\config.yaml $dir\windows\.glaze-wm\config.yaml
pause
