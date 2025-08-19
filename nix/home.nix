pkgs:
let
  dots-directory = /. + builtins.getEnv "DOTS";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
  p = import ./autoprogs.nix {
    inherit pkgs;
    dir = ./programs;
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.manse =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      home.packages =
        with pkgs;
        [
          bitwarden-desktop
          qbittorrent
          vlc
          vesktop
          wf-recorder
          gimp
        ]
        ++ (p.bat.extras pkgs)
        ++ (p.coding pkgs);

      gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      wayland.windowManager.hyprland = p.hyprland { };
      services.wpaperd = p.wpaperd { };

      programs = {
        eza = p.eza { };
        alacritty = p.alacritty { };
        git = p.git { };
        wofi = p.wofi { };
        direnv = p.direnv { };
        neovim = p.neovim { };
        bat = p.bat.bat { };
        bash = p.bash { configFile = dots-directory + ../bash/bashrc; };
        waybar = p.waybar {
          style = dots-directory + ../waybar/style.css;
        };
        lazygit = p.lazygit { };

        gh.enable = true;
      };
      home = {
        pointerCursor = p.pointer pkgs.rose-pine-hyprcursor;
        stateVersion = "24.11";
      };
    };
}
