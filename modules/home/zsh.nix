{ ... }:
{
  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;

      autocd = true;
      defaultKeymap = "viins"; # bindkey -v (vi mode, insert as default)
      shellAliases = {
        update = "nix flake update";
        rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
        clean = "nix-collect-garbage -d && sudo nixos-rebuild boot --flake";
        opti = "nix store optimise";
      };
      history = {
        size = 1000;
        save = 1000;
        path = "$HOME/.histfile";
      };

      # setopt/unsetopt lines with no dedicated home-manager option.
      initContent = ''
        setopt beep nomatch notify
        unsetopt extendedglob

        fastfetch
      '';
    };
  };
}
