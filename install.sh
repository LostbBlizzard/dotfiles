#!/bin/sh

InstallDevTools()
{
$mydir = $(pwd) 

sudo apt update

#install devtools

# -command line tools

# -rust/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# -rust/cargo

# -ziglang
# add linux install
# -ziglang

# -C/C++
sudo apt-get install g++ -y
# -C/C++

# -go
sudo apt install golang-go -y
# -go

# -terminal tools

#  -lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

rm lazygit
rm lazygit.tar.gz
#  -lazygit

# -tmux
apt install tmux -y
# -tmux

# -fzf
sudo apt install fzf -y
# -fzf

# -vifm
sudo apt install vifm -y
# -vifm

# -applications

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc
rm nvim-linux64.tar.gz
# utills

# - clangd
sudo apt-get install clangd -y
# - clangd

# - gdb
sudo apt install gdb -y
# - gdb
}

LinkOrRemove()
{
    if test -f $2; then
      rm $2
    fi

    ln -s $1 $2
}

InstallDevSettings()
{
# set sym-links
mkdir ~/.config
mkdir ~/.config/vifm
mkdir ~/.config/Code
mkdir ~/.config/Code/User

LinkOrRemove $(pwd)/.bash_aliases  ~/.bash_aliases 

LinkOrRemove $(pwd)/.tmux.conf  ~/.tmux.conf 

LinkOrRemove $(pwd)/config/vifm/vifmrc ~/.config/vifm/vifmrc

LinkOrRemove $(pwd)/config/.vimrc ~/.vimrc

LinkOrRemove $(pwd)/config/nvim ~/.config/nvim

LinkOrRemove $(pwd)/Code/User/keybindings.json  ~/.config/Code/User/keybindings.json
LinkOrRemove $(pwd)/Code/User/setting.json ~/.config/Code/User/setting.json

source ~/.bashrc
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

echo "Do you wish to Setup this System?(y/n/tool/config)"

read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
 InstallDevSettings   
 InstallDevTools
elif [ "$answer" != "${answer#[config]}" ] ;then 
 InstallDevSettings   
else
    exit
fi
