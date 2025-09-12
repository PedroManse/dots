{
  enable ? true,
}:
{
  inherit enable;
  extraConfig = ''
    set enable-bracketed-paste
    set menu-complete-display-prefix on
    set show-all-if-ambiguous on
    set colored-stats on
    TAB: menu-complete
  '';
}
