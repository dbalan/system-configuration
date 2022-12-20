{config, pkgs, lib, ...}:

{
    wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      terminal = "${pkgs.kitty}/bin/kitty";
      modifier = "Mod4";
      input = {
        "*" = { xkb_variant = "us"; xkb_layout = "us,de"; xkb_options = "ctrl:nocaps,grp:win_space_toggle"; tap = "enabled"; };
	      "touchpad" = { tap  = "enabled"; click_method = "clickfinger"; dwt = "enabled"; scroll_method = "two_finger"; };
      };
	    floating.criteria = [ { title = "Steam - Update News"; } { class = "Pavucontrol"; } { app_id = "mpv"; }];

      startup = [
        { command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store --no-persist";
        }
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
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

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

  services.swayidle = {
    enable = true;
    events =
      [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock"; }
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock"; }
      ];
    timeouts = [
     { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock"; }
    ];
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    sway-contrib.grimshot
    wl-clipboard
    mako # notification daemon
    clipman
    playerctl
	];
}
