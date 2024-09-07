$dir = Split-Path -Parent $PSScriptRoot

function RemoveFileIfExst($filePath) {
    
    if (Test-Path $filePath) {
        Remove-Item -Path $filePath 
    }

}
# apps
# GlazeWM
##winget install GlazeWM
# GlazeWM

# lazydocker
##go install github.com/jesseduffield/lazydocker@latest
# lazydocker
# apps

# Vim Settings
RemoveFileIfExst $env:USERPROFILE\.vimrc
RemoveFileIfExst $env:USERPROFILE\.vifm\vifmrc
RemoveFileIfExst $env:USERPROFILE\AppData\Local\nvim

cmd /c mklink $env:USERPROFILE\.vimrc $dir\.vimrc
cmd /c mklink $env:USERPROFILE\.vifm\vifmrc $dir\.config\vifm\vifmrc
cmd /c mklink /D $env:USERPROFILE\AppData\Local\nvim $dir\.config\nvim

# VS Code Settings
RemoveFileIfExst $env:APPDATA\Code\User\settings.json 
RemoveFileIfExst $env:APPDATA\Code\User\keybindings.json 

cmd /c mklink $env:APPDATA\Code\User\settings.json $dir\.config\Code\User\settings.json 
cmd /c mklink $env:APPDATA\Code\User\keybindings.json $dir\.config\Code\User\keybindings.json 

RemoveFileIfExst $env:USERPROFILE\.kanata\config.kbd 
RemoveFileIfExst $env:USERPROFILE\.glaze-wm\config.yaml

cmd /c mklink $env:USERPROFILE\.kanata\config.kbd $dir\.config\kanata\config.kbd

cmd /c mklink $env:USERPROFILE\.glaze-wm\config.yaml $dir\windows\.glaze-wm\config.yaml

RemoveFileIfExst $env:USERPROFILE\.vsvimrc
cmd /c mklink $env:USERPROFILE\.vsvimrc $dir\windows\VisualStudio\.vsvimrc

pause
