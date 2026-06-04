{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    # Include home-manager
    /home/manse/dots/nix/home.nix
  ];

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };

    docker.enable = false;
    vmware.host.enable = false;
    virtualbox.guest.enable = false;
    virtualbox.host.enable = false;
  };

  # Enable networking
  networking = {
    hostName = "manse-nix"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # system services
  services = {
    postgresql.enable = false;
    mysql = {
      enable = false;
      package = pkgs.mariadb;
    };

    # login/display manager
    displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        animation = "colormix";
        bigclock = "en";
        bigclock_seconds = true;
        blank_box = true;
        colormix_col1 = "0x00FF00FF";
        colormix_col2 = "0x0000007F";
        colormix_col3 = "0x20000000";
        clock = "%d/%m/%Y";
      };
    };

    # x keyboard
    xserver.xkb = {
      layout = "br";
      variant = "";
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pcscd.enable = true;
  };

  systemd.services = {
    fanControl = {
      wantedBy = [ "multi-user.target" ];
      description = "Start fancontrol program.";
      serviceConfig = {
        Type = "simple";
        ExecStart =
          let
            script_drv = pkgs.writeShellApplication {
              name = "init";
              text = ''
                echo 1 > /sys/class/drm/card1/device/hwmon/hwmon0/fan1_enable
                ${pkgs.lm_sensors}/bin/fancontrol
              '';
            };
          in
          "${script_drv}/bin/init";
      };
    };
  };

  # gpg agent + pin entry
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # Configure console keymap
  console = {
    keyMap = "br-abnt2";
    font = "default8x9";
  };

  security.sudo = {
    enable = true;
    extraRules = [
      # Allow execution of any command by all users in group sudo, requiring a password.
      {
        groups = [
          "sudo"
          "wheel"
        ];
        commands = [ "ALL" ];
      }
    ];
  };
  security.rtkit.enable = true;

  users.users.manse = {
    isNormalUser = true;
    description = "pedro manse";
    extraGroups = [
      "networkmanager"
      "docker"
      "wheel"
      "libvirtd"
      "vboxusers"
    ];
  };

  programs = {
    neovim.enable = true;
    hyprland.enable = true;
    firefox.enable = true;
    steam.enable = true;
    nix-ld = {
      enable = true;
      libraries = [ pkgs.libgcc ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    librewolf
    chromium
    pulseaudio
    man-pages
    man-pages-posix
    pinentry-curses
    pavucontrol
    gcc14
    hyprshot
    hyprlock
    hyprcursor
    nerd-fonts.mononoki
    xorg.xset
    playerctl
    cachix
    lm_sensors
    w3m
  ];

  fonts.packages = [
    pkgs.nerd-fonts.mononoki
  ];

  # original NixOS version; DO *NOT* ALTER
  system.stateVersion = "25.11";
}
