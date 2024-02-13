{ config, pkgs, lib, ... }:

let
  waybarconf =
    import ./waybarconf.nix { swaylock = "${pkgs.swaylock}/bin/swaylock"; };
  switch = pkgs.stdenv.mkDerivation {
    name = "switchWindow";
    propagatedBuildInputs = [ pkgs.python3 ];
    dontUnpack = true;
    installPhase =
      "install -Dm755 ${./switch_windows.py} $out/bin/switch-windows";
  };

in {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      terminal = "${pkgs.kitty}/bin/kitty";
      modifier = "Mod4";
      input = {
        "*" = {
          xkb_variant = "us";
          xkb_layout = "us,de";
          xkb_options = "ctrl:nocaps,grp:win_space_toggle";
          tap = "enabled";
        };
        "touchpad" = {
          tap = "enabled";
          click_method = "clickfinger";
          dwt = "enabled";
          scroll_method = "two_finger";
        };
      };
      floating.criteria = [
        { title = "Steam - Update News"; }
        { class = "Pavucontrol"; }
        { app_id = "mpv"; }
      ];

      startup = [
        {
          command =
            "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store --no-persist";
        }
        {
          command =
            "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components secrets,pkcs11";
        }
        {
          command =
            "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK";
        }
      ];

      window.commands = [
        {
          command = "floating enable, resize set 1500 900, move scratchpad";
          criteria = { class = "Spotify"; };
        }
        {
          command = "floating enable, sticky enable, resize set 757 426";
          criteria = {
            app_id = "firefox";
            title = "^Picture-in-Picture$";
          };
        }
        {
          command = "move scratchpad";
          criteria = { app_id = "Threema Tech Preview"; };
        }
      ];

      bars = [ ];
      keybindings = let
        cfg = config.wayland.windowManager.sway.config;
        modifier = cfg.modifier;
        myFuzzel = ''
          ${pkgs.fuzzel}/bin/fuzzel -b 282828f0 -t ebdbb2ff -D auto -f "Noto Sans:size=30"'';
      in lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec ${cfg.terminal}";
        "${modifier}+Shift+c" = "kill";

        "${modifier}+Shift+v" = ''
          exec ${pkgs.clipman}/bin/clipman pick --tool=CUSTOM --tool-args="${pkgs.fuzzel}/bin/fuzzel -b 282828f0 -t ebdbb2ff -D auto -f 'Iosevka Extended:size=20' -d"'';

        "${modifier}+Shift+w" = "move workspace to output left";
        "${modifier}+Shift+e" = "move workspace to output right";

        "${modifier}+o" =
          "exec ${myFuzzel} | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "${modifier}+p" =
          "exec ${myFuzzel} | ${pkgs.findutils}/bin/xargs swaymsg exec --";

        "${modifier}+x" = "exec ${pkgs.emacs}/bin/emacsclient -c";

        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+Tab" = "focus next | focus prev";
        "${modifier}+Shift+g" = "exec switch-windows";

        "${modifier}+q" = "reload";

        # Sticky floating, good for media
        "${modifier}+Shift+f" = "floating toggle";
        "${modifier}+Shift+s" = "sticky toggle";

        # Brightness
        "XF86MonBrightnessDown" =
          "exec ${pkgs.brightnessctl}/bin/brightnessctl set 100-";
        "XF86MonBrightnessUp" =
          "exec ${pkgs.brightnessctl}/bin/brightnessctl set +100";

        # Volume
        "XF86AudioRaiseVolume" =
          "exec ${pkgs.ponymix}/bin/ponymix -N -t sink increase 5";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.ponymix}/bin/ponymix -N -t sink decrease 5";
        "XF86AudioMute" = "exec toggleVolume";
        "XF86AudioPlay" =
          "exec ${pkgs.playerctl}/bin/playerctl -p spotify\\,%any play-pause";

      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.target = "sway-session.target";
    systemd.enable = true;
    style = builtins.readFile ./waybar.css;
    settings = waybarconf;
  };

  services.swayidle = {
    enable = true;
    extraArgs = [ "idlehint 30" ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock";
      }
    ];
    timeouts = [{
      timeout = 120;
      command = "${pkgs.swaylock}/bin/swaylock -fF -i /home/dj/Pictures/lock";
    }];
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    sway-contrib.grimshot
    wl-clipboard
    mako # notification daemon
    clipman
    playerctl
    gnome.gnome-keyring
    gcr
    (pkgs.writeShellScriptBin "toggleVolume" ''
      #!/bin/bash

      # Arbitrary but unique message tag
      msgTag="changeVolume"

      ponymix -t sink toggle

      # Query amixer for the current volume and whether or not the speaker is muted
      volume="$(ponymix -t sink get-volume)"
      mute="$(ponymix -t sink is-muted || echo not-muted)"
      if [[ $volume == 0 || "$mute" == "" ]]; then
          # Show the sound muted notification
          dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted"
      else
          # Show the volume notification
          dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
          -h int:value:"$volume" "Volume: $volume %"
      fi
    '')
    switch
    fuzzel
  ];
}
