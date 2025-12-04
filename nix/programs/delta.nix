{
  enable ? true,
}:
{
  inherit enable;
  enableGitIntegration = true;
  options = {
    side-by-side = true;
  };
}
