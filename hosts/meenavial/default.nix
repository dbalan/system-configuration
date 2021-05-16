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
  nixpkgs.config.allowUnfree = true;       
  hardware.enableRedistributableFirmware = true;

  networking.hostName = "meenavial"; # Define your hostname.
  networking.extraHosts =  builtins.readFile ../../common-data/blocked.hosts;
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # nsetworking.interfaces.wlp0s20f3.ipv4.addresses = [ {address = "192.168.0.23"; prefixLength = 24; } ];
  networking.enableIPv6 = false;
  # Disable temporary addresses
  networking.interfaces.enp0s31f6.tempAddress = "disabled";
  services.rdnssd.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  # nameservers
  services.nscd.enable = true;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
  #networking.nameservers = ["1.1.1.1" "2001:4860:4860::8888"];
  # Firewall
  networking.firewall = {
     enable = true;
     allowedTCPPorts = [ 22 22000 8000 ];
     checkReversePath = false;
     allowPing = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # virtualisation
  # virtualisation.vswitch.enable = true; # openvswitch
  virtualisation.libvirtd.enable = true;

  # Select internationalisation properties.
  console = {
    font = "sun12x22";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     curl
     mg
     gitAndTools.gitFull
     git-lfs
     alacritty
     dmenu
     feh
     chromium
     gnupg
     fd
     tig
     mosh
     vpnc
     virtmanager
     davfs2
     nfs-utils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
  	   gnupg.agent = { enable = true; enableSSHSupport = true; };
           wireshark.enable = true;
	   slock.enable = true;
           wireshark.package = pkgs.wireshark;
	   ssh.extraConfig =
	     ''
             Host irc
              Hostname ares.dbalan.in
              User root
              Port 2022
             Host www
              Hostname 10.1.10.30
              User root
              Port 22
              ProxyJump dj@ares.dbalan.in
             Host builder
              Hostname ares.dbalan.in
              User root
              Port 3022
             Host photoprism
              Hostname 10.2.10.50
              User dj
              Port 22
              ProxyJump dj@ares.dbalan.in
             '';
  	   light.enable = true;
           adb.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.smartd.enable = true;
  services.physlock.enable = true;
  services.xserver = {
		enable = true;
		layout = "us";
		xkbOptions = "ctrl:nocaps";
                windowManager.xmonad.enable = true;
  };

  services.rpcbind.enable = true;
  services.emacs.enable = true;
  services.davfs2.enable = true;
  # enable docker
  virtualisation.docker.enable = true;
  # enable postgres
  services.postgresql = {
    enable = true;
    authentication = ''
      local all all trust
      host  all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    #settings = ''
    #  log_statement = 'all'
    #'';
  };
  

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Zero Conf (fixme: do we need this?)
  #services.avahi.enable = true;
  #services.avahi.nssmdns = true;

  # update manager for fw
  services.fwupd.enable = true;
  
  services.dbus.packages = with pkgs; [ gnome3.dconf pkgs.blueman ];

  services.logind.lidSwitch = "suspend";

  # hardware keys
  hardware.nitrokey.enable = true;
  services.pcscd.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
	enable = true;
	package = pkgs.pulseaudioFull;
        #configFile = pkgs.writeText "default.pa" ''
	#  load-module module-bluetooth-policy
  	#  load-module module-bluetooth-discover
        #  ## module fails to load with
        #  ##   module-bluez5-device.c: Failed to get device path from module arguments
        #  ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
        #  # load-module module-bluez5-device
        #  # load-module module-bluez5-discover
        #'';
  };
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
  fonts.fonts = with pkgs; [
     noto-fonts
     emojione
     fira-code
     fira-code-symbols
     proggyfonts
     ibm-plex
  ];

  # for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
