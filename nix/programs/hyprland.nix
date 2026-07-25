{
  enable ? true,
}:
{
  inherit enable;
  xwayland.enable = false;
  # TODO: update to lua
  configType = "hyprlang";
  extraConfig = ''
    input {
      kb_layout=br
      accel_profile=flat
      sensitivity=-0.65
    }

    exec-once=waybar
    exec-once=wpaperd
    exec-once=${/home/manse/dots/scripts/start-audio.sh}

    monitor=DP-2, 1920x1080, 0x0, 1
    monitor=HDMI-A-1, preferred, auto, 1, mirror, DP-2

    monitorv2 {
      output = DP-1
      mode = 3440x1440@144.00Hz
      position = 0x0
      scale = 1
    }
  '';

  settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    bind = [
      # program executor
      "ALT, space, exec, pkill wofi ; wofi --show drun"
      # open term
      "SUPER, return, exec, alacritty"
      "SUPER, bracketright, exec, firefox"
      # move self/focus into left/right workspace
      "SUPER, h, workspace, r-1"
      "SHIFT SUPER, h, movetoworkspace, r-1"
      "SUPER, l, workspace, r+1"
      "SHIFT SUPER, l, movetoworkspace, r+1"

      # [move] focus into l/r/u/d within workspace
      "SHIFT ALT, h, movefocus, l"
      "SHIFT ALT, j, movefocus, d"
      "SHIFT ALT, k, movefocus, u"
      "SHIFT ALT, l, movefocus, r"
      "CTRL ALT, h, movewindow, l"
      "CTRL ALT, j, movewindow, d"
      "CTRL ALT, k, movewindow, u"
      "CTRL ALT, l, movewindow, r"

      # alt+f4 -> close
      "ALT, F4, closewindow, active"
      # Sup+f2 -> print screen
      "SUPER, F2, exec, hyprshot --mode region --output-folder /tmp --silent"

      # Audio stuff
      ", XF86AudioLowerVolume, exec, bash ${/home/manse/dots/scripts/change-volume.sh} -5%"
      ", XF86AudioRaiseVolume, exec, bash ${/home/manse/dots/scripts/change-volume.sh} +5%"
      "SHIFT, XF86AudioLowerVolume, exec, bash ${/home/manse/dots/scripts/change-volume.sh} -1%"
      "SHIFT, XF86AudioRaiseVolume, exec, bash ${/home/manse/dots/scripts/change-volume.sh} +1%"
      "CTRL, XF86AudioRaiseVolume, exec, bash ${/home/manse/dots/scripts/change-sink.sh}"
      "CTRL, XF86AudioLowerVolume, exec, bash ${/home/manse/dots/scripts/change-sink.sh}"
      ", XF86AudioPlay, exec, bash ${/home/manse/dots/scripts/toggle-recording.sh}"

      # f11 -> toggle fullscreen
      ", F11, fullscreen"
    ]
    # Sup+N -> workspace N [0;9]
    ++ builtins.genList (n: "SUPER, ${toString (n + 1)}, workspace, ${toString (n + 1)}") 9;
  };
}
