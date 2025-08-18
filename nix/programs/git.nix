{
  enable ? true,
}:
{
  inherit enable;
  userName = "Manse";
  userEmail = "pedro.manse@dmk3.com.br";
  aliases = {
    f = "fetch --prune";
    c = "checkout";
    b = "branch";
  };
  delta = {
    enable = true;
    options = {
      side-by-side = true;
    };
  };
  extraConfig = {
    safe = {
      directory = ".";
    };
    commit = {
      gpgsign = true;
    };
    merge = {
      conflictstyle = "zdiff3";
    };
    diff = {
      colorMoved = false;
      # add "secret.* diff=sopsdiffer" to .gitattributes
      # to enable sops-based viewing
      sopsdiffer = {
        textconv = "sops decrypt";
      };
    };
    # defined in ~/.gitconfig; not here
    #user = { signingkey = ""; };
    push = {
      autoSetupRemote = true;
      default = "current";
    };
    credential = {
      helper = "!/usr/bin/gh auth git-credential";
    };
  };
}
