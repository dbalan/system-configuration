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
    (self: super: { discord = super.discord.overrideAttrs (_: rec { version = "0.0.20"; src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz"; }); })
  ];

  home.sessionVariables = {
    VOLTUS = "/home/dj/code/work/voltus";
    ANSIBLE_STDOUT_CALLBACK = "debug";
    VAULT_GITHUB_TOKEN = "$(cat /run/secrets/github_token)";
  };

  # configure stylish-haskell
  home.file.".stylish-haskell.yml".source = ../../../common-data/stylish-haskell.yml;

  # fixme arbtt
  home.file.".arbtt/categorize.cfg".source = ../../../common-data/arbtt-config.cfg;

  home.sessionPath = [ "$HOME/go/bin" ];

  gtk.enable = true;
  gtk.iconTheme.name = "Adwaita";

  xdg.enable = true;

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
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
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
      nrb = "sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild";
      tree = "exa --tree";
      ha-bookshelf = "hass-cli state toggle switch.bookshelf";
      ha-tv = "hass-cli --token $(cat /run/secrets/home-assistant-api) state toggle switch.media_center";
      ha-led =  "hass-cli --token $(cat /run/secrets/home-assistant-api) state toggle switch.led_strip";
      ha-off = "hass-cli --token $(cat /run/secrets/home-assistant-api) state turn_off switch.bookshelf switch.led_strip switch.media_center";
      headphone = "bluetoothctl connect 4C:87:5D:81:EB:2D";
      headphone-disc = "bluetoothctl disconnect 4C:87:5D:81:EB:2D";
      infrissue = "gh issue create --label \"infra,priority-2\" --project \"Infrastructure Issues\" --web";
      review-pr = "gh pr list -S 'review:required review-requested:@me' -s open --web";
      screenshot= "grimshot save area /home/dj/Pictures/screenshot-$(date +%Y-%m-%d-%H%M).png";
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
      }
    ];
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
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
  };

  programs.firefox = {
    enable = true;
  };

  services.status-notifier-watcher.enable = true;

  services.syncthing.enable = true;

}
