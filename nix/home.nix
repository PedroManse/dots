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
		home.stateVersion = "24.11";
		home.packages = with pkgs; [
			typescript-language-server
			bitwarden-desktop
			qbittorrent
			rustup
			discord
			vlc
		];

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
