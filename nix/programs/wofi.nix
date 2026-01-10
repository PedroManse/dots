{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    insensitive = true;
    show = "drun";
    show_all = true;
    gtk_dark = true;
    allow_markup = true;
    allow_images = true;
    key_expand = "Ctrl-l";
    key_backward = "Up,Ctrl-k";
    key_forward = "Down,Ctrl-j";
  };
}
