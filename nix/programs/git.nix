{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    user = {
      name = "Manse";
      email = "122305437+PedroManse@users.noreply.github.com";
      signingkey = "0CB4AE9E4CE2D6B00D5D35E7B79D6A7491E9A52C";
    };

    alias = {
      f = "fetch --prune";
      c = "checkout";
      b = "branch";
    };
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
    };
    push = {
      autoSetupRemote = true;
      default = "current";
    };
    credential = {
      helper = "!/usr/bin/gh auth git-credential";
    };
  };
}
