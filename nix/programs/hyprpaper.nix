{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    ipc = false;
    splash = false;
    wallpaper = [
      {
        timeout = 60 * 60 * 24;
        monitor = "DP-1";
        path = "${../../.backgrounds}";
      }
    ];
  };
}
