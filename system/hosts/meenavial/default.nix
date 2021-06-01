# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./static-wlan.nix
      ./wlan-list.nix
      # ./open-wlan.nix
    ];

  require = [
    ../pc
  ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
       device = "/dev/disk/by-uuid/34a9365c-e624-4af1-8f3f-52d70c0702cc";
       preLVM = true;
       allowDiscards = true;
       };
  };
  networking.hostName = "meenavial"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # nsetworking.interfaces.wlp0s20f3.ipv4.addresses = [ {address = "192.168.0.23"; prefixLength = 24; } ];
  networking.enableIPv6 = false;
  # Disable temporary addresses
  networking.interfaces.enp0s31f6.tempAddress = "disabled";
  #services.rdnssd.enable = true;
  #services.flatpak.enable = true;
  xdg.portal.enable = true;
  # nameservers
  #services.nscd.enable = true;
  #networking.nameservers = ["1.1.1.1" "2001:4860:4860::8888"];
  # Firewall
  networking.firewall = {
     enable = true;
     allowedTCPPorts = [ 22 22000 8000 ];
     checkReversePath = false;
     allowPing = true;
  };

  # enable postgres
  services.postgresql = {
    enable = true;
    authentication = ''
      local all all trust
      local replication postgres trust
      host  all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    #settings = ''
    #  log_statement = 'all'
    #'';
  };
  
  services.logind.lidSwitch = "suspend";
  hardware.bluetooth.enable = true;

  services.openvpn.servers = {
    #pia = { config = '' config /home/dj/Documents/keys/de_berlin-aes-128-cbc-udp-dns.ovpn ''; };
    p0  = { config = '' config /home/dj/Documents/keys/p0/PortZero_DhananjayBalan_Port-Zero-prd.ovpn ''; };
  };

  networking.wireguard.interfaces = {
    wg0 = {
       ips = ["192.168.40.2/24"];
       privateKeyFile = "/home/dj/code/private/system-configuration/common-data/ares.dbalan.in-privkey";
       peers = [
          { 
             publicKey = "a2cwNbB9hrcjWlLE+iSrywrcQfgX53Nlt/kuAokqChU=";
             allowedIPs = [ "192.168.40.1/32" "192.168.40.0/24" "192.168.31.0/24" "10.11.11.0/24" "10.1.10.0/24" "10.2.10.0/24"];
             endpoint = "ares.dbalan.in:51820";
             persistentKeepalive = 25;
          }
       ];
     };
  };
  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dj = {
     isNormalUser = true;
     home = "/home/dj";
     description = "Dhananjay Balan";
     extraGroups = ["wheel" "network" "audio" "wireshark" "adbusers" "libvirtd"];
     packages = [
	     pkgs.pavucontrol
	     pkgs.steam
       pkgs.spotify
     ];
     shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
