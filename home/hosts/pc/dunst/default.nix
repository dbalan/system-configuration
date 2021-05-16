{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = import ./dunstconf.nix;
  };
}
