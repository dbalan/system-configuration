{ config, pkgs, lib, ... }:

let
  unstable = import <unstable> {};
in
{

  require = [
    ../pc
  ];

  

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
