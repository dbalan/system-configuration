{ config, pkgs, ... }:

{
  require = [ ../../modules/common-home-config ];

  wayland.windowManager.sway.config.output = {
    "DP-1" = {
      bg = "~/Pictures/desk fill";
      position = "0,0";
    };
    "DP-2" = {
      bg = "~/Pictures/desk fill";
      position = "2560,0";
    };
    "HDMI-A-1" = { disable = ""; };
  };

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