{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  p = import ./autoprogs.nix ./programs;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.manse =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home = {
        pointerCursor = {
          name = "rose-pine-cursor";
          size = 24;
          x11.enable = true;
          gtk.enable = true;
          package = pkgs.rose-pine-cursor;
        };
        stateVersion = "24.11";
        packages = with pkgs; [
          sops
          nixfmt-rfc-style
          typescript-language-server
          bitwarden-desktop
          qbittorrent
          rustup
          vlc
          discord
          shellcheck
          wf-recorder
          bat-extras.batman
        ];
      };

      gtk = {
        gtk3 = {
          extraConfig.gtk-application-prefer-dark-theme = true;
        };
      };

      wayland.windowManager.hyprland = p.hyprland { };

      programs = {
        tiny = p.tiny { };
        eza = p.eza { };
        alacritty = p.alacritty { };
        git = p.git { };
        wofi = p.wofi { };
        direnv = p.direnv { };
        neovim = p.neovim { };
        wpaperd = p.wpaperd { };
        bat = p.bat { };

        gh.enable = true;
        waybar.enable = true;

        bash = {
          enable = true;
          bashrcExtra = ''
            . /home/manse/dots/bash/bashrc
          '';
        };
      };
    };
}
