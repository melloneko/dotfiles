{ ... }:
{
  flake.modules.homeManager.packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      vesktop
      prismlauncher
      wezterm
      btop
      fastfetch
      oh-my-zsh
      ani-cli
      playerctl
      unzip
      vim
      zed-editor
      git
      python3
      kdePackages.dolphin
      kdePackages.ark
      xwayland-satellite
      firefox-bin
      obsidian
      keepassxc
      openvpn
      syncthing
      gnumake
      pulseaudio
      yazi
      vscodium
    ];
  };
}
