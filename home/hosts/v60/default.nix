{ config, pkgs, lib, ... }:

let
  unstable = import <unstable> {};
in
{

  require = [
    ../pc
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      terminal = "${pkgs.kitty}/bin/kitty";
      modifier = "Mod4";
      input = {
        "*" = { xkb_variant = "us"; xkb_options = "ctrl:nocaps"; tap = "enabled"; };
	      "touchpad" = { tap  = "enabled"; click_method = "clickfinger"; dwt = "enabled"; scroll_method = "two_finger"; };
      };
	    floating.criteria = [ { title = "Steam - Update News"; } { class = "Pavucontrol"; } ];
	    output = {
	      "eDP-1" = { bg = "~/Pictures/desk-ber.jpg fill"; scale = "1.4"; };
	      "DP-5" = { bg = "~/Pictures/desk-ber.jpg fill"; };
	      "DP-6" = { bg = "~/Pictures/desk-ber.jpg fill"; };
	    };

      startup = [
        { command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store"; }
      ];

      bars = [];
	    keybindings = let
	      cfg = config.wayland.windowManager.sway.config;
	      modifier = cfg.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec ${cfg.terminal}";
        "${modifier}+Shift+c" = "kill";

        "${modifier}+Shift+v" = "exec ${pkgs.clipman}/bin/clipman pick -t rofi";

        "${modifier}+Shift+w" = "move workspace to output left";
        "${modifier}+Shift+e" = "move workspace to output right";

        "${modifier}+o" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "${modifier}+p" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons | ${pkgs.findutils}/bin/xargs swaymsg exec --";

        "${modifier}+x" = "exec ${pkgs.emacs}/bin/emacsclient -c";

        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+Tab" = "focus next | focus prev";
        "${modifier}+Shift+g" = "exec ${pkgs.rofi}/bin/rofi -show window";

        "${modifier}+q" = "reload";

        # Brightness
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +2%";

        # Volume
        "XF86AudioRaiseVolume" = "exec ${pkgs.pavucontrol}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pavucontrol}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "XF86AudioMute" = "exec ${pkgs.pavucontrol}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";

      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.target = "sway-session.target";
    systemd.enable = true;
    style = builtins.readFile ./waybar.css;
    settings = import ./waybarconf.nix;
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

  services.swayidle = {
    enable = true;
    events =
      [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/cern-lock.jpg"; }
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/cern-lock.jpg"; }
      ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/cern-lock.jpg"; }
    ];
  };


  home.packages = with pkgs; [
  	swaylock
		swayidle
  	wl-clipboard
  	mako # notification daemon
    clipman
  	dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
	];
}
