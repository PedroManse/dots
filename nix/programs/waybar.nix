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
    "custom/audio" = {
      exec = "bash ${/home/manse/dots/scripts/waybar-show-sink-volume.bash}";
      return-type = "json";
      on-click = "bash ${/home/manse/dots/scripts/change-sink.sh}";
    };
    "hyprland/workspaces" = {
      format = "{id}";
    };
    "clock" = {
      format = "{:%b %d | %H:%M}";
    };
    "memory" = {
      format = "{used:.1f} / {total:.1f}";
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
        "custom/audio"
        "custom/record"
        "tray"
        "clock"
        "custom/power"
      ];
    }
    // modules;
  };
}
