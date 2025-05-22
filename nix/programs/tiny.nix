{
  enable ? true,
}:
{
  inherit enable;
  settings = {
    servers = [
      {
        addr = "irc.tilde.chat";
        port = "6697";
        # nickserv_ident: <password here>;
        tls = true;
        realname = "manse";
        nicks = [ "manse" ];
        join = [
          "#ctrl-c"
          "#linux"
          "#rust"
        ];
      }
    ];
    key_map = {
      alt_j = "tab_prev";
      alt_k = "tab_next";
      ctrl_k = "messages_scroll_up";
      ctrl_j = "messages_scroll_down";
    };
  };
}
