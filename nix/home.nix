pkgs:
let
  home-manager = <home-manager>;
  p = import ./autoprogs.nix {
    inherit pkgs;
    dir = ./programs;
  };
  l = import ./autolinks.nix {
    to_dir = ".local/share/applications/";
    from_dir = ./links;
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

      home.file = l;

      home.packages =
        with pkgs;
        [
          gnumake
          prismlauncher
          w3m
          gamemode
          gamescope
          (heroic.override {
            extraPkgs =
              pkgs': with pkgs'; [
                gamescope
                gamemode
              ];
          })
          qbittorrent
          vlc
          vesktop
          wf-recorder
          gimp
          cachix
          kdePackages.kdenlive
        ]
        ++ (p.bat.extras pkgs)
        ++ (p.coding pkgs);

      gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      wayland.windowManager.hyprland = p.hyprland { };
      #services.wpaperd = p.wpaperd { };
      services.hyprpaper = p.hyprpaper { };

      programs = {
        readline = p.inputrc { };
        eza = p.eza { };
        alacritty = p.alacritty { };
        delta = p.delta { };
        git = p.git { };
        wofi = p.wofi { };
        neovim = p.neovim { inherit pkgs; };
        bat = p.bat.bat { };
        bash = p.bash { configFile = /home/manse/dots/bash/bashrc; };
        waybar = p.waybar {
          style = "${/home/manse/dots/waybar/style.css}";
        };
        aerc = p.aerc { lib = pkgs.lib; };

        gh.enable = true;
      };
      home = {
        pointerCursor = p.pointer pkgs.rose-pine-hyprcursor;
        stateVersion = "24.11";
      };
    };
}
