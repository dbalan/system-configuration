# common for pc
{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  networking.extraHosts = builtins.readFile ../../../common-data/blocked.hosts;
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "sun12x22";
    keyMap = "us";
  };

  # systemd stop naggin  
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     curl
     mg
     gitAndTools.gitFull
     git-lfs
     kitty
     dmenu
     feh
     chromium
     gnupg
     fd
     tig
     mosh
     vpnc
     virtmanager
     nfs-utils
  ];

  
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

  virtualisation =  {
      libvirtd.enable = true;
      docker.enable = true;
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

  services.rpcbind.enable = true;
  services.emacs.enable = true;

  services.printing.enable = true;
  services.upower.enable = true;

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
  };

    services.xserver = {
                enable = true;
                layout = "us";
                xkbOptions = "ctrl:nocaps";
                windowManager.xmonad.enable = true;
  };


}
