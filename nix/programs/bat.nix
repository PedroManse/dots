{
  extras =
    pkgs: with pkgs; [
      bat-extras.batman
    ];

  bat =
    {
      enable ? true,
    }:
    {
      inherit enable;
      config = {
        "theme" = "zenburn";
      };
    };
}
