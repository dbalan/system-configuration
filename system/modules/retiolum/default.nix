{ config, pkgs, lib, ... }:

with lib;

let

  netname = "retiolum";
  cfg = config.networking.retiolum;

  retiolum = pkgs.fetchgit {
    url = "https://github.com/krebs/retiolum.git";
    rev = "2bde49b654225c90172f02f534c7c7ebf053c317";
    sha256 = "sha256-abalI3Msrx/Wk9B5wB9bTo1VB90PsBLchUZvHnU2CPA=";
  };

in {
  options = {
    networking.retiolum.ipv4 = mkOption {
      type = types.str;
      description = ''
        own ipv4 address
      '';
    };
    networking.retiolum.ipv6 = mkOption {
      type = types.str;
      description = ''
        own ipv6 address
      '';
    };
    networking.retiolum.nodename = mkOption {
      type = types.str;
      default = config.networking.hostName;
      description = ''
        tinc network name
      '';
    };
  };

  config = {
    services.tinc.networks.${netname} = {
      name = cfg.nodename;
      extraConfig = ''
        LocalDiscovery = yes
        AutoConnect = yes
      '';
    };
    systemd.services."tinc.${netname}" = {
      preStart = ''
        cp -R ${retiolum}/hosts /etc/tinc/retiolum/ || true
      '';
    };

    networking.extraHosts =
      builtins.readFile (toString "${retiolum}/etc.hosts");

    environment.systemPackages = [ pkgs.tinc_pre ];

    networking.firewall.allowedTCPPorts = [ 655 ];
    networking.firewall.allowedUDPPorts = [ 655 ];
    #services.netdata.portcheck.checks.tinc.port = 655;

    systemd.network.enable = true;
    systemd.network.networks = {
      "${netname}".extraConfig = ''
        [Match]
        Name = tinc.${netname}

        [Network]
        Address=${cfg.ipv4}/12
        Address=${cfg.ipv6}/16
      '';
    };
  };
}
