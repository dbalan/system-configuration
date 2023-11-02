{ config, lib, pkgs, ... }:

{

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  require = [ ../pc ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/465f5302-3abb-465c-8806-79747691e37e";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "kimchi";
  networking.interfaces.eno1.useDHCP = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 22000 9090 ];
    allowPing = true;
  };

  # Define a user account. Don't forget to set a password .
  users.users.dj = {
    isNormalUser = true;
    home = "/home/dj";
    description = "Dhananjay Balan";
    extraGroups = [ "wheel" "network" "audio" "libvirtd" "adbusers" "docker" ];
    packages = [ pkgs.pavucontrol pkgs.steam pkgs.spotify ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.pam.services.swaylock = { };

  services.openssh.enable = false;
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';

  # user space cachefiles for network mounts
  services.cachefilesd.enable = true;

  # xbox controller
  hardware.xone.enable = true;

  home-manager.users.dj = ./home-config/default.nix;

  sops.secrets = let
    defopt = {
      mode = "0600";
      owner = config.users.users.dj.name;
      group = config.users.users.dj.group;
      sopsFile = ../../../secrets/kimchi/secrets.yaml;
    };
  in { "wg_kimchi_dbalan_in" = { } // defopt; };

  # fixme
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "192.168.40.6/24" ];
      privateKeyFile = config.sops.secrets."wg_kimchi_dbalan_in".path;
      peers = [{
        publicKey = "a2cwNbB9hrcjWlLE+iSrywrcQfgX53Nlt/kuAokqChU=";
        allowedIPs = [
          "192.168.40.1/32"
          "192.168.40.0/24"
          "10.11.11.0/24"
          "10.1.10.0/24"
          "10.2.10.0/24"
          "10.3.10.0/24"
        ];
        endpoint = "ares.dbalan.in:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
