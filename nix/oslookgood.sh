
echo "Make the OS look good"

dconf load /org/gnome/terminal/legacy/profiles:/ < ~/dotfiles/nix/gnome-terminal-profiles.txt
dconf load /org/cinnamon/ < ~/dotfiles/nix/cinnamon.dconf
