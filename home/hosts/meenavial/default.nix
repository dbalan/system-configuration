{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
{

  require = [
    ../pc
  ];

  programs.autorandr.enable = true;

  # nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/0.0.14/discord-0.0.14.tar.gz"; });})];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
