{ config, pkgs, lib, ... }:

{

  require = [
    ../../../modules/pc
    ../../../modules/wayland
  ];

  wayland.windowManager.sway.config.output = {
    "eDP-1" = { bg = "~/Pictures/desk-ber.jpg fill"; scale = "1.1"; };
    "DP-5" = { bg = "~/Pictures/desk-ber.jpg fill"; };
    "DP-6" = { bg = "~/Pictures/desk-ber.jpg fill"; };
  };

  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
	        {
	          criteria = "eDP-1";
            scale = 1.1;
	        }
	      ];
      };

      docked = {
        outputs = [
          {
            criteria = "Dell Inc. DELL UP2516D 3JV4059IA31L";
            transform = "normal";
            position = "2560,0";
            scale = 1.0;
          }
          { criteria = "eDP-1";
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
