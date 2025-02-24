# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			/etc/nixos/hardware-configuration.nix
			/home/manse/dots/nix/home.nix
		];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "manse-nix"; # Define your hostname.
	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

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

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	#services.xserver.enable = true;

	# postgres
	services.postgresql.enable = true;

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "br";
		variant = "";
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
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.manse = {
		isNormalUser = true;
		description = "pedro manse";
		extraGroups = [ "networkmanager" "wheel" ];
	};

	# no need for steam to be system-wide
	# Install system-wide
	programs = {
		hyprland.enable = true;
		firefox.enable = true;
		steam.enable = true;
		nix-ld = {
			enable = true;
			libraries = with pkgs; [
				libgcc
			];
		};
	};


	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	nix.extraOptions = ''
keep-outputs = true
keep-derivations = true
	'';

	environment.systemPackages = with pkgs; [
		pinentry-curses
		pavucontrol
		gcc14
		hyprshot
		hyprlock
	];

	# original NixOS version; DO *NOT* ALTER
	system.stateVersion = "24.11";
}
