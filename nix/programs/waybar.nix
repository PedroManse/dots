let
  player = {
    "exec" = "playerctl metadata -f '{{emoji(status)}} {{title}}'";
    "interval" = 15;
    "on-click" = "playerctl play-pause";
    "tooltip" = true;
  };
  vpn = {
    "exec" = "bash ~/code/umind/vpn.sh";
    "return-type" = "json";
    "interval" = 15;
    "on-click" = "bash ~/code/umind/vpn.sh --toggle";
    "tooltip" = true;
  };
  pulseaudio = {
    "format-icons" = {
      "headphone" = "";
      "speaker" = "󰜟";
    };
    "on-click" = "bash ~/code/umind/PA-sink-rotation.sh 1";
    "format" = {
      "format" = "{icon} {volume}";
    };
  };
  workspaces = {
    "format" = "{icon}{id}{icon}";
    "format-icons" = {
      "active" = "|";
      "default" = "";
    };
  };
  clock = {
    format = ''{:%b %d | %H:%M}'';
  };
  memory = {
    format = ''{used:0.1f} / {total:0.1f}'';
  };
in

{
  style,
  enable ? true,
}:
{
  inherit enable style;
  settings = {
    mainBar = {
      "layer" = "top";
      "modules-left" = [ "hyprland/workspaces" ];
      "modules-right" = [
        "custom/vpn"
        "pulseaudio"
        "cpu"
        "memory"
        "tray"
        "clock"
      ];
      "hyprland/workspaces" = workspaces;
      "pulseaudio" = pulseaudio;
      "clock" = clock;
      "memory" = memory;
      "custom/vpn" = vpn;
      "custom/player" = player;
    };
  };
}
