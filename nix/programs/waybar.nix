let
  player = {
    "exec" = "playerctl metadata -f '{{emoji(status)}} {{title}}'";
    "interval" = 5;
    "on-click" = "playerctl play-pause";
    "tooltip" = true;
  };
  vpn = {
    "exec" = "bash ~/dots/waybar/vpn.sh";
    "return-type" = "json";
    # executes directly to run as root
    # > see at security.sudo on configuration.nix
    "interval" = 15;
    "on-click" = "sudo ~/dots/waybar/vpn.sh --toggle";
  };
  pulseaudio = {
    "format-icons" = {
      "headphone" = "";
      "speaker" = "󰜟";
    };
    "on-click" = "bash ~/dots/waybar/change-sink.sh 1";
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
