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
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 20

# node

# lazydocker
go install github.com/jesseduffield/lazydocker@latest
# lazydocker

# - zsh
sudo apt install zsh -y
# - zsh

# dotnet
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh
rm ./dotnet-install.sh
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.bashrc
# dotnet


# bashrc
echo 'export EDITOR=nvim' >> ~/.bashrc
echo 'export PATH="$PATH:$HOME/prebuilt/bin"' >> ~/.bashrc

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

echo 'if [ ! -f ~/.gnupg/gpg-agent.conf ]; then' >> ~/.bashrc
echo '  mkdir -p ~/.gnupg' >> ~/.bashrc
echo '  echo "pinentry-program /usr/bin/pinentry-tty" > ~/.gnupg/gpg-agent.conf' >> ~/.bashrc
echo '  echo "made gpg-agent.conf" ' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
# bashrc

# i3
sudo apt install i3 -y
# i3

# i3lock
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y

mkdir ~/prebuilt
git clone https://github.com/Raymo111/i3lock-color ~/prebuilt/i3lock
currentdir=$(pwd)
cd ~/prebuilt/i3lock
./install-i3lock-color.sh

cd $currentdir

# i3lock


# premake
mkdir -p ~/prebuilt/bin
mkdir -p ~/prebuilt/premake5

curl -L https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-linux.tar.gz -o ~/prebuilt/premake.tar.gz
tar -xvzf ~/prebuilt/premake.tar.gz --directory ~/prebuilt/premake5
rm ~/prebuilt/premake.tar.gz 

ln -s ~/prebuilt/premake5/premake5 ~/prebuilt/bin/premake5

# premake plugins
mkdir ~/.premake
git clone https://github.com/tarruda/premake-export-compile-commands ~/.premake/export-compile-commands
echo "require \"export-compile-commands\"" >> ~/.premake/premake5-system.lua 
# premake plugins

# premake

# mdbook 
mkdir ~/prebuilt/mdbook
curl -L https://github.com/rust-lang/mdBook/releases/download/v0.4.40/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar.gz -o ~/prebuilt/mdbook.tar.gz
tar -zxvf ~/prebuilt/mdbook.tar.gz --directory ~/prebuilt/mdbook
rm ~/prebuilt/mdbook.tar.gz
ln -s ~/prebuilt/mdbook/mdbook ~/prebuilt/bin/mdbook
# mdbook 


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
    mkdir -p ~/prebuilt/kanata
    mkdir -p ~/prebuilt/bin

    curl -L https://github.com/jtroo/kanata/releases/download/v1.6.1/kanata -o ~/prebuilt/kanata/kanata
    chmod +x ~/prebuilt/kanata/kanata
    ln -s ~/prebuilt/kanata/kanata ~/prebuilt/bin/kanata
    
    sudo groupadd input
    sudo groupadd uinput
    sudo usermod -aG input $(whoami)
    sudo usermod -aG uinput $(whoami)
    
    sudo mkdir -p /etc/udev/rules.d/
    sudo touch /etc/udev/rules.d/99-uinput.rules 
    sudo sh -c "echo -n \"\" > /etc/udev/rules.d/99-uinput.rules"
    
    rulestext="KERNEL==\\\"uinput\\\", MODE=\\\"0660\\\", GROUP=\\\"uinput\\\", OPTIONS+=\\\"static_node=uinput\\\""
    sudo sh -c "echo \"$rulestext\" >> /etc/udev/rules.d/99-uinput.rules"
    
    mkdir -p ~/.config/systemd/user/

    echo -n "" > ~/.config/systemd/user/kanata.service 
    echo "[Unit]" >> ~/.config/systemd/user/kanata.service 
    echo "Description=Kanata Service" >> ~/.config/systemd/user/kanata.service 
    echo "[Service]" >> ~/.config/systemd/user/kanata.service 
    echo "ExecStartPre=/sbin/modprobe uinput " >> ~/.config/systemd/user/kanata.service 
    echo "ExecStart=/home/$(whoami)/prebuilt/kanata/kanata -c /home/$(whoami)/.config/kanata/config.kbd" >> ~/.config/systemd/user/kanata.service 
    echo "Restart=no" >> ~/.config/systemd/user/kanata.service 
    echo "[Install]" >> ~/.config/systemd/user/kanata.service 
    echo "WantedBy=multi-user.target" >> ~/.config/systemd/user/kanata.service 

    systemctl --user start kanata.service
    systemctl --user enable kanata.service
}


InstallGUI()
{
    mkdir -p ~/prebuilt/bin

    # godot
    curl -L https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_mono_linux_x86_64.zip -o ~/prebuilt/godot.zip
    unzip ~/prebuilt/godot.zip -d ~/prebuilt/godot
    rm ~/prebuilt/godot.zip

    ln -s ~/prebuilt/godot/Godot_v4.3-stable_mono_linux_x86_64/Godot_v4.3-stable_mono_linux.x86_64 ~/prebuilt/bin/godot 
    # godot

    # LibreSprite
    curl -L https://github.com/LibreSprite/LibreSprite/releases/download/v1.1/libresprite-development-linux-x86_64.zip -o ~/prebuilt/libresprite.zip
    unzip ~/prebuilt/libresprite.zip -d ~/prebuilt/libresprite
    rm ~/prebuilt/libresprite.zip
    chmod +x ~/prebuilt/libresprite/LibreSprite-x86_64.AppImage

    ln -s ~/prebuilt/libresprite/LibreSprite-x86_64.AppImage ~/prebuilt/bin/libresprite 
    # LibreSprite
    
    # chromium
    # curl -L https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots -o ~/prebuilt/chromium.zip
    # unzip ~/prebuilt/chromium.zip -d ~/prebuilt/chromium
    # rm ~/prebuilt/chromium.zip
    # ln -s ~/prebuilt/chromium/chrome-linux/chrome ~/prebuilt/bin/chromium 

    # chromium extensions
    # vimiumid="dbepggeogbaibhgnhhndojpepiihcmeb"
    # showtabnumbersid="pflnpcinjbcfefgbejjfanemlgcfjbna"
    # Chrometabsid="fipfgiejfpcdacpjepkohdlnjonchnal"
    # firefoxthemeid="pinabllndpmfdcknifcfcmdgdngjcfii"

    # ~/prebuilt/bin/chromium --new-tab "https://chromewebstore.google.com/detail/$vimiumid"
    # ~/prebuilt/bin/chromium --new-tab "https://chromewebstore.google.com/detail/$showtabnumbersid"
    # ~/prebuilt/bin/chromium --new-tab "https://chromewebstore.google.com/detail/$Chrometabsid"
    # ~/prebuilt/bin/chromium --new-tab "https://chromewebstore.google.com/detail/$firefoxthemeid"
    # chromium extensions
    # chromium
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

echo "Do you wish to Setup this System?(y/n/tool/config/kanata/guiapp/all)"

read answer


if [ "$answer" != "${answer#[Yy]}" ] ;then 
    InstallDevTools
    InstallDevSettings   
elif [ "$answer" = "config" ] ;then 
    InstallDevSettings   
elif [ "$answer" = "kanata" ] ;then 
    SetupKanata
elif [ "$answer" = "guiapp" ] ;then 
    InstallGUI   
elif [ "$answer" = "all" ] ;then 
    InstallDevTools
    InstallDevSettings   
    SetupKanata
    InstallGUI
else
    exit
fi
