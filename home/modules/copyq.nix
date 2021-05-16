{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.copyq;
in {
  options.services.copyq = {
    enable = mkEnableOption "copyq";
  };

  config = mkIf cfg.enable {
    systemd.user.services.copyq = {
      Unit = {
        Description = "Advanced clipboard manager with editing and scripting features.";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${pkgs.copyq}/bin/copyq";
        Restart = "on-abort";
      };
    };
  };
}
  
