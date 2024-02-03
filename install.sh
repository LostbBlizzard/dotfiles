#!/bin/sh

InstallDevTools()
{

sudo apt update

#install devtools

# -command line tools

# -rust/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# -rust/cargo

# -ziglang
sudo apt install zig
# -ziglang

# -C/C++
sudo apt-get install g++
# -C/C++

# -go
sudo apt install golang-go
# -go

# -terminal tools

#  -lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
#  -lazygit

# -tmux
apt install tmux
# -tmux

# -fzf
sudo apt install fzf
# -fzf

    
# -applications
sudo apt install helix

# utills

# - clangd
sudo apt-get install clangd
# - clangd

# vscode-lldb
sudo apt install vscode-lldb
# vscode-lldb


# set sym-links

mkdir ~/.config/helix/config.toml

ln -s $(pwd)/config/helix/config.toml ~/.config/helix/config.toml 
ln -s $(pwd)/.bash_aliases  ~/.bash_aliases 

ln -s $(pwd)/.tmux.conf  ~/.tmux.conf 
}

CYAN_B='\033[1;96m'
YELLOW_B='\033[1;93m'
RED_B='\033[1;31m'
GREEN_B='\033[1;32m'
PLAIN_B='\033[1;37m'
RESET='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'

echo "${CYAN_B} The setup script will do the following:${RESET}\n"

echo "Setup Dotfiles"
echo "Install packages"
echo "Configure system/n"

echo "Do you wish to Setup this System?(y/n)"

read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
    InstallDevTools
else
    exit
fi
