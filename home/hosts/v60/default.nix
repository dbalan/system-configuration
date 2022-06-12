{ config, pkgs, lib, ... }:

{

  require = [
    ../pc
    ../wayland
  ];

  wayland.windowManager.sway.config.output = {
    "eDP-1" = { bg = "~/Pictures/desk-ber.jpg fill"; scale = "1.4"; };
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
            scale = 1.5;
	        }
	      ];
      };

      docked = {
        outputs = [
          {
            criteria = "Dell Inc. DELL UP2516D 3JV4059IA31L";
            transform = "90";
            position = "2560,0";
          }
          { criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL UP2516D 3JV4059I688L";
            position = "0,0";
            transform = "normal";
          }
        ];
      };
    };
  };

}
