{enable?true}: {
	inherit enable;
	extraConfig = ''
input {
	kb_layout=br
	accel_profile=flat
	sensitivity=-0.65
}

env = HYPRCURSOR_THEME,rose-pine-hyprcursor
env = HYPRCURSOR_SIZE,24
env = XCURSOR_THEME,rose-pine-xcursor
env = XCURSOR_SIZE,24
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
		bind = let
			inherit (builtins) map concatLists genList;
			flatMap = f: xs: concatLists (map f xs);
		in
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
			", F11, fullscreen"

			"SHIFT ALT, h, movefocus, l"
			"SHIFT ALT, j, movefocus, d"
			"SHIFT ALT, k, movefocus, u"
			"SHIFT ALT, l, movefocus, r"
			"CTRL ALT, h, movewindow, l"
			"CTRL ALT, j, movewindow, d"
			"CTRL ALT, k, movewindow, u"
			"CTRL ALT, l, movewindow, r"

			"SUPER SHIFT CTRL, l, exec, hyprlock"
		]
			++ map (n: "SUPER, ${toString n}, workspace, ${toString n}") ( genList (n: n+1) 9 )
		;
	};
}
