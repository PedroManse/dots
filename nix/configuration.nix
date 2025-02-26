{ config, pkgs, ... }: {
	imports = [
		# Include the results of the hardware scan.
		/etc/nixos/hardware-configuration.nix
		# Include home-manager
		/home/manse/dots/nix/home.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "manse-nix"; # Define your hostname.

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

	# postgres
	services.postgresql.enable = true;

	# login/display manager
	services.displayManager.ly.enable = true;

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
	# services.printing.enable = true;

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
		pulseaudio
		man-pages
		man-pages-posix
		pinentry-curses
		pavucontrol
		gcc14
		hyprshot
		hyprlock
		hyprcursor
	];

	# original NixOS version; DO *NOT* ALTER
	system.stateVersion = "24.11";
}
