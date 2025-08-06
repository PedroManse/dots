{
  configFile,
  enable ? true,
}:
{
  inherit enable;
  bashrcExtra = ''
    . ${configFile}
  '';
}
