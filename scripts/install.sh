#!/bin/sh

InstallDevTools()
{
    mydir=$(pwd) 

    sudo apt update
    sudo apt install curl tar git vim stow -y

#install devtools

# -command line tools

# -rust/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# -rust/cargo

# -ziglang
# add linux install
# -ziglang

# -C/C++
sudo apt-get install g++ -y
# -C/C++

# -go
curl -L https://go.dev/dl/go1.22.4.linux-amd64.tar.gz -O
sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
rm go1.22.4.linux-amd64.tar.gz
echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.bashrc
# -go

# install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
source ~/.bashrc
nvm install node
# install node

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
sudo apt install tmux -y
# -tmux

# -fzf
sudo apt install fzf -y
# -fzf

# -vifm
sudo apt install vifm -y
# -vifm

# pbcopy
sudo apt install xsel -y
# pbcopy

# -ripgrep
sudo apt-get install ripgrep
# -ripgrep

# -applications

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc
rm nvim-linux64.tar.gz
# utills

# - tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# - tmux plugins

# - powerline
sudo apt install powerline -y
# - powerline

# - clangd
sudo apt-get install clangd -y
# - clangd

# - gdb
sudo apt install gdb -y
# - gdb

# - pass
sudo apt-get install pass -y
# - pass

# node 

# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# download and install Node.js (you may need to restart the terminal)
bash nvm install 20
# node

# lazydocker
go install github.com/jesseduffield/lazydocker@latest
# lazydocker

# - zsh
sudo apt install zsh -y
# - zsh

echo 'export EDITOR=nvim' >> ~/.bashrc

echo 'export PATH="$PATH:$HOME/go/bin"' >> ~/.bashrc

echo 'export GIT_ASKPASS="$HOME/dotfiles/scripts/git_env_password.sh"' >> ~/.bashrc

# from https://www.ricalo.com/blog/install-powerline-ubuntu/#install-powerline
echo '# Powerline configuration' >> ~/.bashrc
echo 'if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then' >> ~/.bashrc
echo 'powerline-daemon -q' >> ~/.bashrc
echo 'POWERLINE_BASH_CONTINUATION=1' >> ~/.bashrc
echo 'POWERLINE_BASH_SELECT=1' >> ~/.bashrc
echo 'source /usr/share/powerline/bindings/bash/powerline.sh' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

echo 'if [ ! -f ~/.gnupg/gpg-agent.conf ]; then' .. >> ~/.bashrc
echo '  mkdir -p ~/.gnupg' >> ~/.bashrc
echo '  echo "pinentry-program /usr/bin/pinentry-tty" > ~/.gnupg/gpg-agent.conf' >> ~/.bashrc
echo '  echo "made gpg-agent.conf' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y

git clone https://github.com/Raymo111/i3lock-color ~/prebuilt/
cd ~/prebuilt/i3lock-color/
./install-i3lock-color.sh

cd $mydir

~/.bashrc
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
    stow .

    ~/.tmux/plugins/tpm/scripts/install_plugins.sh

    chmod +X $(pwd)/scripts/git_env_password.sh
    chmod +X $(pwd)/scripts/tmux-sessionizer

    . ~/.bashrc
}


SetupKanata()
{
    cargo install kanata
    sudo groupadd input
    sudo groupadd uinput
    sudo usermod -aG input $(whoami)
    sudo usermod -aG uinput $(whoami)

    sudo mkdir -p /etc/udev/rules.d/

    sudo touch /etc/udev/rules.d/99-uinput.rules 
    echo -n "" > /etc/udev/rules.d/99-uinput.rules 
    
    echo "KERNEL==\"uinput\", MODE=\"0660\", GROUP=\"uinput\", OPTIONS+=\"static_node=uinput\"" >> /etc/udev/rules.d/99-uinput.rules
    systemctl --user start kanata.service
    systemctl --user enable kanata.service
}


InstallGUI()
{


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

echo "Do you wish to Setup this System?(y/n/tool/config/kanata,all)"

read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
    InstallDevTools
    InstallDevSettings   
elif [ "$answer" != "${answer#[config]}" ] ;then 
    InstallDevSettings   
elif [ "$answer" != "${answer#[kanata]}" ] ;then 
    SetupKanata
elif [ "$answer" != "${answer#[all]}" ] ;then 
    InstallDevTools
    InstallDevSettings   
    SetupKanata
else
    exit
fi
