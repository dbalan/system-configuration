{ config, pkgs, lib, ... }:

{

  require = [ ../../../modules/pc ../../../modules/wayland ];

  wayland.windowManager.sway.config.output = {
    "eDP-1" = {
      bg = "~/Pictures/desk tile";
      scale = "1.1";
    };
    "DP-5" = { bg = "~/Pictures/desk tile"; };
    "DP-6" = { bg = "~/Pictures/desk tile"; };
    "DP-4" = { bg = "~/Pictures/desk tile"; };
  };

  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [{
          criteria = "eDP-1";
          scale = 1.1;
        }];
      };

      docked = {
        outputs = [
          {
            criteria = "Dell Inc. DELL UP2516D 3JV4059IA31L";
            transform = "normal";
            position = "2560,0";
            scale = 1.0;
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL UP2516D 3JV4059I688L";
            position = "0,0";
            transform = "normal";
            scale = 1.0;
          }
        ];
      };
      travel = {
        outputs = [
          {
            criteria = "DO NOT USE - RTK DR1602 Unknown";
            transform = "normal";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "eDP-1";
            transform = "normal";
            scale = 1.1;
            position = "2560,0";

          }
        ];
      };
      commo = {
        outputs = [
          {
            criteria = "Unknown ASUS VG289 0x0000A74D";
            transform = "normal";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "eDP-1";
            position = "3840,0";
            scale = 1.1;
          }
        ];
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

}
