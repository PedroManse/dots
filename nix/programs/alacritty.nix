{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    window = {
      padding = {
        x = 2;
        y = 2;
      };
    };
    font = {
      #normal.family = "mononoki";
      normal.family = "Mononoki Nerd Font";
      size = 9.6;
    };
    colors.primary.background = "#000000";
    mouse.hide_when_typing = true;
    general.live_config_reload = true;
  };
}
