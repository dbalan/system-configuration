{ config, lib, pkgs, ... }:

{
  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks = { preNew = "mbsync --all"; };
    };
    neomutt.enable = true;
  };
  accounts.email = {
    accounts.fastmail = {
      primary = true;
      address = "mail@dbalan.in";
      realName = "Dhananjay Balan";
      imap.host = "imap.fastmail.com";
      smtp.host = "smtp.fastmail.com";
      userName = "mail@dbalan.in";
      passwordCommand = "cat /var/run/secrets/fastmail";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
      signature = {
        text = ''
          dbalan
          @notmycommit@notwork.in
        '';
      };
    };
  };
}
