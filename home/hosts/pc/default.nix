# common for pc
{ config, lib, pkgs, ... }:

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
  # nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { version = "0.0.14"; src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/0.0.14/discord-0.0.14.tar.gz"; }); })];

  
  home.sessionVariables = {
    EDITOR = "mg";
    ANSIBLE_STDOUT_CALLBACK = "debug";
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
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };

  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = self: [ self.taffybar ];
    config = pkgs.writeText "xmonad.hs" (builtins.readFile ../../../common-data/xmonad.hs);
  };

  services.redshift = {
    enable = true;
    longitude = "13.404954";
    latitude = "52.520008";
  };
  services.status-notifier-watcher.enable = true;
  services.taffybar.enable = true;
  services.copyq.enable = true;
  services.syncthing.enable = true;
  
}
