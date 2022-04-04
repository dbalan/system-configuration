# common for pc
{ config, lib, pkgs, ... }:

with lib;

let
  unstable = import <unstable> {};
in
{
  imports = [
    ./kitty.nix
    ./dunst
    ./packages
    ./ssh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dj";
  home.homeDirectory = "/home/dj";
  # overlays we would need
  nixpkgs.overlays = [
    (self: super: { discord = super.discord.overrideAttrs (_: { version = "0.0.17"; src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.17.tar.gz"; }); })

  ];


  home.sessionVariables = {
    EDITOR = "mg";
    ANSIBLE_STDOUT_CALLBACK = "debug";
    HASS_SERVER = "http://192.168.20.57:8123";
    HASS_TOKEN = builtins.readFile ../../../common-data/home-assistant.key;
  };


  # set HiDPI hints -- run xrdb -merge ~/.Xresources if changes.
  home.file.".Xresources" = {
    source = ../../../common-data/hidpi-xresources;
    onChange = ''
             echo "Re-merging xresources"
             $DRY_RUN_CMD xrdb -merge ~/.Xresources
             '';
  };

  # configure stylish-haskell
  home.file.".stylish-haskell.yml".source = ../../../common-data/stylish-haskell.yml;

  # fixme arbtt
  home.file.".arbtt/categorize.cfg".source = ../../../common-data/arbtt-config.cfg;

  home.file.".config/taffybar/taffybar.hs" = {
    source = ../../../common-data/taffybar.hs;
    onChange = ''
        rm /home/dj/.cache/taffybar/taffybar-linux-x86_64
        systemctl --user restart taffybar
    '';
  };

  gtk.enable = true;
  gtk.iconTheme.name = "Adwaita";

  programs.command-not-found.enable = true;
  programs.direnv = {
      enableZshIntegration = true;
      enable = true;
  };
  programs.git = {
    enable = true;
    userName = "Dhananjay Balan";
    userEmail = "mail@dbalan.in";
    extraConfig = {
      init = { defaultBranch = "trunk"; };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      e = "emacsclient -t";
      ec = "emacsclient -c";
      mirc = "mosh -p 61000 irc";
      ns = "nix-shell";
      nsp = "nix-shell -p";
      cat = "bat";
      scp = "rsync -Pv";
      ls = "exa";
      tree = "exa --tree";
      today = "rtm lsd dueBefore:tomorrow NOT status:complete";
      planner = "rtm lsd NOT due:never NOT status:complete";
      week = "rtm planner NOT due:never NOT status:complete";
      ha-bookshelf = "hass-cli state toggle switch.bookshelf";
      ha-tv = "hass-cli state toggle switch.media_center";
      ha-led =  "hass-cli state toggle switch.led_strip";
      ha-off = "hass-cli state turn_off switch.bookshelf switch.led_strip switch.media_center";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = mkMerge [
        {
          add_newline = false;
          format = concatStrings [
            "$line_break"
            "$package"
            "$line_break"
            "$character"
          ];
          scan_timeout = 10;
          character = {
            success_symbol = "➜";
            error_symbol = "➜";
          };
          package.disabled = true;
          memory_usage.threshold = -1;
          aws.style = "bold blue";
          battery = {
            charging_symbol = "⚡️";
            display = [{
              threshold = 10;
              style = "bold red";
            }];
          };
        }

        {
          aws.disabled = true;

          battery.display = [{
            threshold = 30;
            style = "bold yellow";
          }];
        }
      ];
  };
  
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
  };
  
  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    haskellPackages = unstable.haskellPackages;
    extraPackages = self: [ self.taffybar ];
    config = pkgs.writeText "xmonad.hs" (builtins.readFile ../../../common-data/xmonad.hs);
  };

  services.redshift = {
    enable = true;
    longitude = "13.404954";
    latitude = "52.520008";
  };
  services.status-notifier-watcher.enable = true;
  services.taffybar = {
    enable = true;
    package = unstable.taffybar;
  };

  services.syncthing.enable = true;

}
