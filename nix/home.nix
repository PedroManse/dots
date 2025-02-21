{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
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
			dbeaver-bin
			bitwarden-desktop
			qbittorrent
			rustup
			discord
			alacritty
			gh
			sqlite
			vlc
		];

		programs = {
			bat.enable = true;
			eza = {
				enable = true;
				colors = "always";
				git = true;
			};
			waybar.enable = true;
			wofi = {
				enable = true;
				settings = {
					allow_images=true;
					key_expand="Right";
				};
			};
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
				delta = {
					enable = true;
				};
				extraConfig = {
					safe = {
						directory = ".";
					};
					commit = {
						gpgsign = true;
					};
					merge = {
						conflictstyle = "diff3";
					};
					core = {
						editor = "nvim";
					};
					diff = {
						colorMoved = false;
					};
					# defined in ~/.gitconfig; not here
					#user = { signingkey = ""; };
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
					. ~/dots/bashrc
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
					"ALT, space, exec, pkill wofi ; $menu"
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
					", F11, fullscreen"
					"CTRL ALT, l, movewindow, r"
					"SUPER SHIFT CTRL, l, exec, hyprlock"
					"SUPER, 1, workspace, 1"
					"SUPER, 2, workspace, 2"
					"SUPER, 3, workspace, 3"
					"SUPER, 4, workspace, 4"
					"SUPER, 5, workspace, 5"
					"SUPER, 6, workspace, 6"
					"SUPER, 7, workspace, 7"
					"SUPER, 8, workspace, 8"
					"SUPER, 9, workspace, 9"
				];
			};
		};

	};
}
