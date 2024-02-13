{ swaylock, ... }: {
  mainBar = {
    layer = "top";
    position = "top";
    height = 18;
    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ "sway/window" ];
    modules-right = [
      "temperature"
      "cpu"
      "memory"
      "network"
      "pulseaudio"
      "clock"
      "battery"
      "idle_inhibitor"
      "tray"
    ];

    # Modules configuration
    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{name}: {icon}";
      format-icons = {
        "urgent" = "";
        "focused" = "";
        "default" = "";
      };
    };

    "sway/mode" = { "format" = "{}"; };

    "cpu" = {
      "format" = "🏭 {usage}%";
      "tooltip" = false;
    };
    "memory" = { "format" = "💾 {used:0.1f}G"; };

    "network" = {
      "family" = "ipv6";
      "format-wifi" =
        "<span color='#589df6'></span> <span color='gray'>{essid}</span> {frequency} <span color='#589df6'>{signaldBm} dB</span> <span color='#589df6'>⇵</span> {bandwidthUpBits}/{bandwidthDownBits}";
      "format-ethernet" = "{ifname}: {ipaddr}/{cidr} 🔗";
      "format-linked" = "{ifname} (No IP) ";
      "format-disconnected" = "Disconnected ⚠";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      "interval" = 5;
    };

    "pulseaudio" = {
      "format" = "{icon} {volume}% {format_source}";
      "format-muted" = "🔇 {format_source}";
      "format-bluetooth" = "{icon} {volume}% {format_source}";
      "format-bluetooth-muted" = "🔇 {format_source}";

      "format-source" = " {volume}%";
      "format-source-muted" = "";

      "format-icons" = {
        "headphones" = "";
        "handsfree" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [ "🔈" "🔉" "🔊" ];
      };
      "on-click" = "ponymix -N -t sink toggle";
      "on-click-right" = "ponymix -N -t source toggle";
    };

    "clock" = {
      "interval" = 1;
      "format" = "⏰ {:%H:%M:%S}";
      "tooltip-format" = "{:%Y-%m-%d | %H:%M:%S}";
      # "format-alt"= "{:%Y-%m-%d}"
    };

    "battery" = {
      "states" = {
        "good" = 95;
        "format" = "<span color='#e88939'>{icon}</span> {capacity}% ({time})";
        "warning" = 20;
        "critical" = 10;
      };
      "format-charging" = "<span color='#e88939'>󰂄 </span> {capacity}%";
      "format-plugged" =
        "<span color='#e88939'>{icon} </span> {capacity}% ({time})";
      #"format-good"= ""; // An empty format will hide the module
      #"format-full"= "";
      "format-icons" = [ "" "" "" "" "" ];
    };

    "idle_inhibitor" = {
      "format" = "<span color='#589df6'>{icon}</span>";
      "format-icons" = {
        "activated" = "";
        "deactivated" = "";
      };
      "on-click-right" = "${swaylock} -eFfki /home/dj/Pictures/lock";
    };

    "tray" = {
      "icon-size" = 21;
      "spacing" = 10;
    };
  };
}
