{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    user = {
      name = "Manse";
      email = "122305437+PedroManse@users.noreply.github.com";
      signingkey = "DF91ACD478B72A2567F611F36D2111546E0577D9";
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
