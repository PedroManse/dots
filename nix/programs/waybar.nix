{
  style,
  enable ? true,
}:
let
  icons = {
    power = "⏻ ";
  };
  modules = {
    "custom/record" = {
      exec = "bash ${/home/manse/dots/scripts/recording.sh}";
      return-type = "json";
      on-click = "bash ${/home/manse/dots/scripts/toggle-recording.sh}";
    };
    "custom/power" = {
      format = icons.power;
      tooltip = false;
      menu = "on-click";
      menu-file = /home/manse/dots/waybar/power.xml;
      menu-actions = {
        shutdown = "shutdown 0";
        reboot = "reboot";
      };
    };
    "pulseaudio" = {
      on-click = "bash -c \"source ~/dots/bash/bashrc && _pwa_rotate_real_output_sinks\"";
      format-icons = {
        headphone = "";
        speaker = "󰜟";
      };
      # this was broken with qpwgraph
      #on-click = "bash ${/home/manse/dots/scripts/change-sink.sh} 1";
      format = {
        format = "{icon} {volume}";
      };
    };
    "hyprland/workspaces" = {
      format = "{id}";
    };
    "clock" = {
      format = ''{:%b %d | %H:%M}'';
    };
    "memory" = {
      format = ''{used:.1f} / {total:.1f}'';
    };
  };
in

{
  inherit enable style;
  settings = {
    mainBar = {
      "layer" = "top";

      "modules-left" = [
        #"custom/player"
        "cpu"
        "memory"
      ];
      "modules-center" = [
        "hyprland/workspaces"
      ];
      "modules-right" = [
        "pulseaudio"
        "custom/record"
        "tray"
        "clock"
        "custom/power"
      ];
    }
    // modules;
  };
}
