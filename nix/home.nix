{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
	p = import ./autoprogs.nix ./programs;
in
{
	imports = [
		(import "${home-manager}/nixos")
	];

	home-manager.users.manse = {pkgs, ...}: {
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
				typescript-language-server
				bitwarden-desktop
				qbittorrent
				rustup
				vlc
			];
		};

		gtk = {
			gtk3 = {
				extraConfig.gtk-application-prefer-dark-theme = true;
			};
		};

		wayland.windowManager.hyprland = p.hyprland {};

		programs = {
			eza = p.eza {};
			alacritty = p.alacritty {};
			git = p.git {};
			wofi = p.wofi {};
			direnv = p.direnv {};
			neovim = p.neovim {};

			bat.enable = true;
			gh.enable = true;
			waybar.enable = true;


			bash = {
				enable = true;
				bashrcExtra = ''
					. ~/dots/bashrc
				'';
			};
		};
	};
}
