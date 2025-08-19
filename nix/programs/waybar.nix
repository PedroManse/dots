{
  style,
  enable ? true,
}:
let
  modules = {
    "custom/player" = {
      exec = "playerctl metadata -f '{{emoji(status)}} {{title}}'";
      interval = 5;
      on-click = "playerctl play-pause";
      tooltip = true;
    };
    "custom/vpn" = {
      exec = "bash ~/dots/waybar/vpn.sh";
      return-type = "json";
      # executes directly to run as root
      # > see at security.sudo on configuration.nix
      interval = 15;
      on-click = "sudo ~/dots/waybar/vpn.sh --toggle";
    };
    "pulseaudio" = {
      format-icons = {
        headphone = "";
        speaker = "󰜟";
      };
      on-click = "bash ~/dots/waybar/change-sink.sh 1";
      format = {
        format = "{icon} {volume}";
      };
    };
    "hyprland/workspaces" = {
      format = "{icon}{id}{icon}";
      format-icons = {
        active = "|";
        default = "";
      };
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
        "cpu"
        "memory"
      ];
      "modules-center" = [
        "hyprland/workspaces"
      ];
      "modules-right" = [
        "custom/vpn"
        "pulseaudio"
        "tray"
        "clock"
      ];
    } // modules;
  };
}
