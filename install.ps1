$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

function RemoveFileIfExst($filePath) {
    
    if (Test-Path $filePath) {
        Remove-Item -Path $filePath 
    }

}


# Vim Settings
RemoveFileIfExst $env:USERPROFILE\.vimrc
cmd /c mklink $env:USERPROFILE\.vimrc $dir\.vimrc

# VS Code Settings
RemoveFileIfExst $env:APPDATA\Code\User\settings.json 
RemoveFileIfExst $env:APPDATA\Code\User\keybindings.json 

cmd /c mklink $env:APPDATA\Code\User\settings.json $dir\config\Code\User\settings.json 
cmd /c mklink $env:APPDATA\Code\User\keybindings.json $dir\config\Code\User\keybindings.json 

# Helix Editor Settings
Remove-Item -Path -Path $env:APPDATA\helix\config.toml 

cmd /c mklink $env:APPDATA\helix\config.toml $dir\config\helix\config.toml
pause