{
  enable ? true
}: {
  inherit enable;
  config = {
    "--theme" = "zenburn";
  };
}
