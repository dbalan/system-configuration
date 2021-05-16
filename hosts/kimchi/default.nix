{ config, lib, pkgs, ...}:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # fixme
  boot.initrd.luks.devices = {
    root = {
       device = "/dev/disk/by-uuid/465f5302-3abb-465c-8806-79747691e37e";
       preLVM = true;
       allowDiscards = true;
       };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  networking.hostName = "kimchi";

  networking.extraHosts = builtins.readFile ../../common-data/blocked.hosts;
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # fixme
  networking.interfaces.enp2s0f0u6u3.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "sun12x22";
    keyMap = "us";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     curl
     mg
     gitAndTools.gitFull
     git-lfs
     kitty
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

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 22000 ];
    allowPing = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  virtualisation =  {
      libvirtd.enable = true;
      docker.enable = true;
  };

  # Define a user account. Don't forget to set a password .
  users.users.dj = {
     isNormalUser = true;
     home = "/home/dj";
     description = "Dhananjay Balan";
     extraGroups = ["wheel" "network" "audio" "libvirtd" ];
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
  hardware.steam-hardware.enable = true;

  # hardware keys
  hardware.nitrokey.enable = true;
  services.pcscd.enable = true;

  # update manager for fw
  services.fwupd.enable = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf pkgs.blueman ];

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
  services.mullvad-vpn.enable = false;
  services.hardware.xow.enable = true;

  # fixme
  networking.wireguard.interfaces = {
    wg0 = {
       ips = ["192.168.40.6/24"];
       privateKeyFile = "/home/dj/code/private/system-configuration/common-data/kimchi.ber.dbalan.in-privkey";
       peers = [
          {
             publicKey = "a2cwNbB9hrcjWlLE+iSrywrcQfgX53Nlt/kuAokqChU=";
             allowedIPs = [ "192.168.40.1/32" "192.168.40.0/24" "10.11.11.0/24" "10.1.10.0/24" "10.2.10.0/24"];
             endpoint = "ares.dbalan.in:51820";
             persistentKeepalive = 25;
          }
       ];
     };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
           gnupg.agent = { enable = true; enableSSHSupport = true; };
           wireshark.enable = true;
           slock.enable = true;
           dconf.enable = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
