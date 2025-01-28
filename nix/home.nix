{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
	imports = [
		(import "${home-manager}/nixos")
	];

	home-manager.users.manse = {pkgs, ...}: {
		/* The home.stateVersion option does not have a default and must be set */
		nixpkgs.config.allowUnfree = true;
		home.stateVersion = "24.11";
		home.packages = with pkgs; [
			typescript-language-server
			dbeaver-bin
			bitwarden-desktop
			qbittorrent
			rustup
			discord
			alacritty
			gh
			sqlite
		];
		/* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

		#TODO: make gpg-agent find pinEntry pkg
		#services.gpg-agent = {
		#	enable = true;
		#	pinentryPackage = pkgs.pinentry-curses;
		#};
		#programs.gpg.enable = true;
		programs = {
			waybar.enable = true;
			wofi.enable = true;
			kitty.enable = true;
			direnv = {
				enable = true;
				enableBashIntegration = true;
				nix-direnv.enable = true;
			};

			neovim = {
				enable = true;
				defaultEditor = true;
			};

			git = {
				enable = true;
				userName = "Pedro Manse";
				userEmail = "pedro.manse@dmk3.com.br";
				aliases = {
					f = "fetch --prune";
					c = "checkout";
					b = "branch";
				};
				extraConfig = {
					safe = {
						directory = ".";
					};
					commit = {
						gpgsign = false;
					};
					merge = {
						conflictstyle = "diff3";
					};
					core = {
						editor = "nvim";
						pager = "delta";
					};
					interactive = {
						diffFilter = "delta --color-only";
					};
					diff = {
						colorMoved = false;
					};
					push = {
						autoSetupRemote = true;
						default = "current";
					};
					credential = {
						helper = "!/usr/bin/gh auth git-credential";
					};
				};
			};

			bash = {
				enable = true;
				bashrcExtra = ''
					. ~/.shrc.sh
				'';
			};
		};
		wayland.windowManager.hyprland = {
			enable = true;
			extraConfig = ''
input {
	kb_layout=br
	accel_profile=flat
	sensitivity=-0.65
}

exec-once=waybar
exec-once=hyprpaper

			'';

			settings = {
				"$mod" = "SUPER";
				"$terminal" = "alacritty";
				"$browser" = "firefox";
				"$menu" = "wofi --show drun";

				bindm = [
					"SUPER, mouse:272, movewindow"
					"SUPER, mouse:273, resizewindow"
				];
				bind =
				[
					"ALT, space, exec, $menu"
					"SUPER, return, exec, $terminal"
					"SUPER, bracketright, exec, $browser"
					"SUPER, h, workspace, r-1"
					"SHIFT SUPER, h, movetoworkspace, r-1"
					"SUPER, l, workspace, r+1"
					"SHIFT SUPER, l, movetoworkspace, r+1"
					"ALT, F4, closewindow, active"
					"SUPER, F2, exec, hyprshot --mode region --output-folder /tmp --silent"
					", XF86AudioLowerVolume, exec, pactl set-sink-volume $(pactl get-default-sink) -5%"
					", XF86AudioRaiseVolume, exec, pactl set-sink-volume $(pactl get-default-sink) +5%"
					"SHIFT, XF86AudioLowerVolume, exec, pactl set-sink-volume $(pactl get-default-sink) -1%"
					"SHIFT, XF86AudioRaiseVolume, exec, pactl set-sink-volume $(pactl get-default-sink) +1%"
					"CTRL, XF86AudioRaiseVolume, exec, bash /home/manse/code/umind/PA-sink-rotation.sh 1"
					"CTRL, XF86AudioLowerVolume, exec, bash /home/manse/code/umind/PA-sink-rotation.sh -1"
					"SHIFT ALT, h, movefocus, l"
					"SHIFT ALT, j, movefocus, d"
					"SHIFT ALT, k, movefocus, u"
					"SHIFT ALT, l, movefocus, r"
					"CTRL ALT, h, movewindow, l"
					"CTRL ALT, j, movewindow, d"
					"CTRL ALT, k, movewindow, u"
					"CTRL ALT, l, movewindow, r"
				];
			};
		};

	};
}
