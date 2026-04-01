{
  enable ? true,
  lib,
}:
let
  personal = rec {
    password = lib.trim (builtins.readFile /home/manse/.aerc_acc-personal.pass);
    addr = lib.trim (builtins.readFile /home/manse/.aerc_acc-personal.addr);
    addr_percent = builtins.replaceStrings [ "@" ] [ "%40" ] addr;
  };
in
{
  inherit enable;
  extraAccounts = {
    Personal = {
      source = "imaps://${personal.addr_percent}:${personal.password}@imap.gmail.com:993";
      outgoing = "smtp://${personal.addr_percent}:${personal.password}@smtp.gmail.com:587";
      default = "INBOX";
      from = "Manse <${personal.addr}>";
      copy-to = "sent";
      cache-headers = "true";
    };
  };
  extraConfig.general.unsafe-accounts-conf = true;
  extraConfig.filters = {
    "text/plain" = "colorize";
    "text/calendar" = "calendar";
    "message/delivery-status" = "colorize";
    "message/rfc822" = "colorize";
    "text/html" = "html | colorize";
    ".headers" = "colorize";
  };
}
