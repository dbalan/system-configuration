# common for pc
{ config, lib, pkgs, ... }:

with lib;

let unstable = import <unstable> { };
in {
  imports = [ ./kitty.nix ./dunst ./packages ./ssh ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dj";
  home.homeDirectory = "/home/dj";
  # overlays we would need
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (_: rec {
        version = "0.0.21";
        src = builtins.fetchTarball
          "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      });
    })
  ];

  home.sessionVariables = {
    VOLTUS = "/home/dj/code/work/voltus";
    VAULT_GITHUB_TOKEN = "$(gh auth token)";
    EDITOR = "emacsclient -t";
    zlong_ignore_cmds = "git tig vim emacsclient e vim ssh psql pgcli";
  };

  # configure stylish-haskell
  home.file.".stylish-haskell.yml".source =
    ../../../common-data/stylish-haskell.yml;

  # fixme arbtt
  home.file.".arbtt/categorize.cfg".source =
    ../../../common-data/arbtt-config.cfg;

  home.sessionPath = [ "$HOME/go/bin" ];

  gtk.enable = true;
  gtk.iconTheme.name = "Adwaita";

  xdg.enable = true;

  programs.command-not-found.enable = false;

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enableZshIntegration = true;
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Dhananjay Balan";
    userEmail = "mail@dbalan.in";
    extraConfig = {
      github.user = "dbalan";
      init = { defaultBranch = "trunk"; };
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      e = "emacsclient -c -n";
      et = "emacsclient -t";
      mirc = "mosh -p 61000 irc";
      ns = "nix-shell";
      nsp = "nix-shell -p";
      cat = "bat";
      scp = "rsync -Pv";
      ls = "eza --icons";
      nrb = "sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild";
      tree = "eza --tree";
      ha-bookshelf = "hass-cli state toggle switch.bookshelf";
      ha-tv =
        "hass-cli --token $(cat /run/secrets/home-assistant-api) state toggle switch.media_center";
      ha-led =
        "hass-cli --token $(cat /run/secrets/home-assistant-api) state toggle switch.led_strip";
      ha-off =
        "hass-cli --token $(cat /run/secrets/home-assistant-api) state turn_off switch.bookshelf switch.led_strip switch.media_center";
      headphone = "bluetoothctl connect 4C:87:5D:81:EB:2D";
      headphone-disc = "bluetoothctl disconnect 4C:87:5D:81:EB:2D";
      review-pr =
        "gh pr list -S 'review:required review-requested:@me' -s open --web";
      block-pr = "gh pr list --author=@me --web";
      screenshot =
        "grimshot save area /home/dj/Pictures/screenshot-$(date +%Y-%m-%d-%H%M).png";
      # open file
      of =
        "rg $1 --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}'";
      #TODO convert to a babashka script
      gof = "gh browse $(of | cut -d : -f 1)";

    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
    plugins = [{
      name = "zlong_alert";
      src = pkgs.fetchFromGitHub {
        owner = "dbalan";
        repo = "zlong_alert.zsh";
        rev = "d4635c099e158bb134f266d1b6e36c726586bfbd";
        sha256 = "sha256-m0UJjSKtOC7LzQH9M2JmyVT5XkWMNvoZzrDW6LOvvFg=";
      };
    }];
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.rofi = {
    enable = true;
    theme = "Monokai";
    package =
      pkgs.rofi.override { plugins = [ pkgs.rofi-emoji pkgs.wl-clipboard ]; };
  };

  programs.firefox = { enable = true; };

  services.status-notifier-watcher.enable = true;

  services.syncthing.enable = true;

  services.recoll = {
    enable = true;
    settings = {
      nocjk = true;
      loglevel = 5;
      topdirs = [ "~/Documents" ];
    };
    startAt = "hourly";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
      "inode/directory" = [ "pcmanfm.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "text/plain" = [ "org.kde.kate.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "brave-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "brave-browser.desktop" ];
      "x-scheme-handler/mailto" = [ "userapp-Thunderbird-VBQQO1.desktop" ];
      "message/rfc822" = [ "userapp-Thunderbird-VBQQO1.desktop" ];
      "x-scheme-handler/mid" = [ "userapp-Thunderbird-VBQQO1.desktop" ];
      "x-scheme-handler/webcal" = [ "brave-browser.desktop" ];
      "text/calendar" = [ "userapp-Thunderbird-IBAQO1.desktop" ];
      "application/x-extension-ics" = [ "userapp-Thunderbird-IBAQO1.desktop" ];
      "x-scheme-handler/webcals" = [ "userapp-Thunderbird-IBAQO1.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
      "x-scheme-handler/tg" = [ "userapp-Telegram Desktop-FLEEV1.desktop" ];
      "x-scheme-handler/tootle" = [ "com.github.bleakgrey.tootle.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        [ "writer.desktop" ];
      "image/tiff" = [ "org.kde.gwenview.desktop" ];
    };
  };
}
