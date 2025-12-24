{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    allow_images = true;
    key_expand = "Right";
    gtk_dark = true;
  };
}
