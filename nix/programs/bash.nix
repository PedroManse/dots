{
  configFile,
  enable ? true,
}:
{
  inherit enable;
  bashrcExtra = ''
    . ${/home/manse/.shenv.bash}
    . ${/home/manse/dots/bash/bashrc}
  '';
}
