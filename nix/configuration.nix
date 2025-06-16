# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    /home/nixos/dots/nix/home.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Enable networking
  networking = {
    hostName = "manse-nix"; # Define your hostname.
    networkmanager.enable = true;
  };

  # services
  services = {
    # postgres
    postgresql.enable = true;

    # mysql (with mariadb)
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    # login/display manager
    displayManager.ly.enable = true;
  };

  # gpg agent + pin entry
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    description = "manse";
    extraGroups = [
      "networkmanager"
      "docker"
      "wheel"
      "vboxusers"
      "vboxsf" # vbox shared folder
    ];
  };

  programs = {
    neovim.enable = true;
    nix-ld = {
      enable = true;
      libraries = [ pkgs.libgcc ];
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-33.4.11"
    ];
  };

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    pinentry-curses
    gcc14
  ];

  # original NixOS version; DO *NOT* ALTER
  system.stateVersion = "24.11";
}
