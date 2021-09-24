# common for pc
{ config, lib, pkgs, ... }:

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
    (self: super: { discord = super.discord.overrideAttrs (_: { version = "0.0.14"; src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/0.0.16/discord-0.0.16.tar.gz"; }); })

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
      ha-bookshelf = "hass-cli state toggle switch.0x7cb03eaa0a087273";
      ha-tv = "hass-cli state toggle switch.0x7cb03eaa0a08a1e7";
      ha-led =  "hass-cli state toggle switch.0x7cb03eaa0a08a806";
      ha-off = "hass-cli state turn_off switch.0x7cb03eaa0a08a806 switch.0x7cb03eaa0a087273 switch.0x7cb03eaa0a08a1e7";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
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

  services.copyq.enable = true;
  services.syncthing.enable = true;

}
