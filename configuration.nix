# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.noctalia-greeter.nixosModules.default
      inputs.spicetify-nix.nixosModules.default
    ];
  programs.noctalia-greeter = {
	enable = true;
  };
  programs.steam = {
	enable = true;
  };
  programs.niri.enable = true;
  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;
  programs.serpantinum.enable = true;

 # services.displayManager.gdm.enable = true;
 # services.displayManager.gdm.wayland = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.blueman.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
     # LE = {
       # MinConnectionInterval = 7;
       # MaxConnectionInterval = 9;
       # ConnectionLatency = 0;
     # };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  boot = {
      extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
  };

hardware.xpadneo.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."shrek" = {
    isNormalUser = true;
    description = "shrek";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;
 programs.spicetify =  let
     # For Flakeless:
     # spicePkgs = spicetify-nix.packages;

     # With flakes:
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
   in {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblockify
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
       beautifulLyrics
       oneko
       songstats
       spicyLyrics
       availabilityMap
     ];

     theme = spicePkgs.themes.matte;
    };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Greeter
    greetd
    noctalia-greeter
    # Window Manager
    niri

    # Music
    mpv
    mpd
    rmpc
    # Gaming

    steam
    # Programmation
    # Utilities
    kdePackages.kdeconnect-kde
    home-manager
   # wget
  ];
fonts.packages = with pkgs; [
  nerd-fonts.fira-code
];
environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
services.power-profiles-daemon.enable = true;
services.upower.enable = true;
system.autoUpgrade.enable  = true;
system.autoUpgrade.allowReboot  = true;
services.mpd = {
  enable = true;
  settings = {
    music_directory = "/home/shrek/Music";
    audio_output = [
      {
        type = "alsa";
        name = "Output";
        format = "44100:16:2";
        mixer_type = "hardware";
        mixer_device = "default";
        mixer_control = "PCM";
      }
      {
        type = "fifo";
        name = "Visualizer";
        path = "/tmp/mpd.fifo";
        format = "44100:16:2";
      }
    ];
  };
};
  # Enable the OpenSSH daemon.
services.openssh = {
  enable = true;
  openFirewall = true;
  settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    PermitRootLogin = "no";
    AllowUsers = [ "myUser" ];
    MaxAuthTries = 3;
    PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
  };
};
xdg.portal = {
  enable = true;
  extraPortals = pkgs.lib.mkForce [ pkgs.xdg-desktop-portal-gtk ];
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
networking.firewall.enable = false;
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
