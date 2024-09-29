# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "SomeLaptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "Ubuntu Mono" ];
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  # i3 window manager
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lostblizzard = {
    isNormalUser = true;
    description = "lostblizzard";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
    packages = with pkgs; [
	 libresprite 
         go
         zig
         nodejs_22
         cargo
         premake
         mdbook
         lazygit
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # Backround color #1F1F28
  programs.bash = { 
    interactiveShellInit = ''
      . .bash_aliases
 
      if [ "$EUID" -ne 0 ]; then
     
      DIRECTORY=~/.tmux/plugins/tpm
      if [ ! -d "$DIRECTORY" ]; then
        mkdir -p ~/.tmux/plugins/tpm
        git clone https://github.com/tmux-plugins/tpm $DIRECTORY
        ~/.tmux/plugins/tpm/scripts/install_plugins.sh
      fi
    

      if [ ! -f ~/.gnupg/gpg-agent.conf ]; then
        mkdir -p ~/.gnupg
        echo "pinentry-program /run/current-system/sw/bin/pinentry-tty" > ~/.gnupg/gpg-agent.conf
        echo "made gpg-agent.conf"
      fi
      
      fi
      
      export EDITOR=nvim
      export GIT_ASKPASS="$HOME/dotfiles/scripts/git_env_password.sh"
      export PATH="$PATH:~/prebuilt/bin"
      
      # from https://www.ricalo.com/blog/install-powerline-ubuntu/#install-powerline
      if [ -f ${pkgs.powerline}/share/bash/powerline.sh ]; then
      
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      
      . ${pkgs.powerline}/share/bash/powerline.sh

      fi
    
  ''; 
  }; 

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          ;; Map caps lock to ese and  hold for lctrl+arrows
          
          (defalias 
            escarrows (tap-hold 200 200 esc (layer-while-held arrows))
          )
          
          (defsrc k h j l caps)
          
          (deflayer base    k    h    j    l  @escarrows)
          
          (deflayer arrows  up   left down right @escarrows)
        '';
      };
    };
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # stuff you forget that are not biltin
  vim   
  neovim   
  gnumake
  git 
  curl
  zip
  unzip
  stow
  pass
  gnupg
  xsel
  xclip
  gcc
  gdb
  clang
  clang-tools
  python3
  tmux
  pinentry-tty  

  #Next gen command line tools
  i3
  i3status
  i3lock-color
  dmenu
  ripgrep
  fzf
  powerline

  # GUI Apps
  firefox
  chromium
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      # Vimium
      "dbepggeogbaibhgnhhndojpepiihcmeb"
      # Chrome Show Tab Numbers
     "pflnpcinjbcfefgbejjfanemlgcfjbna"
      # Keyboard shortcuts to close Chrome tabs
      "fipfgiejfpcdacpjepkohdlnjonchnal"
      # Firefox Dark Theme
      "pinabllndpmfdcknifcfcmdgdngjcfii"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
