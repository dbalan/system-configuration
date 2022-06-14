# common for pc
{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlaysb = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

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
    chromium
    curl
    fd
    feh
    git-lfs
    gitAndTools.gitFull
    gnupg
    kitty
    mg
    mosh
    nfs-utils
    tig
    virtmanager
    vpnc
    pavucontrol
  ];


  # Enable sound.
  sound.enable = false;
  xdg.portal.wlr.enable = true;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  # hardware.pulseaudio = {
	#   enable = true;
	#   package = pkgs.pulseaudioFull;
  #       #configFile = pkgs.writeText "default.pa" ''
	#   #  load-module module-bluetooth-policy
  # 	#  load-module module-bluetooth-discover
  #       #  ## module fails to load with
  #       #  ##   module-bluez5-device.c: Failed to get device path from module arguments
  #       #  ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
  #       #  # load-module module-bluez5-device
  #       #  # load-module module-bluez5-discover
  #       #'';
  # };

  virtualisation =  {
      libvirtd.enable = true;
      docker.enable = true;
  };

  fonts.fonts = with pkgs; [
    #(nerdfonts.override { fonts = [ "FiraCode" "Hack" "DroidSansMono" ]; })
    (nerdfonts.override {
      fonts = [ 
        "FiraCode"
      ];
    })
    fira-code
    fira
    hack-font
     noto-fonts
     emojione
     proggyfonts
     ibm-plex
     vollkorn
     merriweather
    noto-fonts-extra
     #font-awesome
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Fira Code" "Hack" ];
  # for steam
  hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true;

  # hardware keys
  hardware.nitrokey.enable = true;
  services.pcscd.enable = true;

  # opengl
  hardware.opengl.enable = true;
  # logitech
  hardware.logitech.wireless = {
    enable = true;
  };

  # enable brother scanner
  hardware.sane = {
    enable = true;
    brscan4.enable = true;
  };

  # update manager for fw
  services.fwupd.enable = true;
  services.dbus.packages = with pkgs; [ pkgs.dconf pkgs.blueman ];

  # enable mullvad
  services.mullvad-vpn.enable = true;

  services.smartd.enable = true;
  # services.physlock.enable = true;

  services.rpcbind.enable = true;
  services.emacs = {
    enable = true;
    #package = pkgs.emacsUnstable;
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.upower.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  
  # ios usb access
  # services.usbmuxd.enable = true;

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
             PubkeyAcceptedKeyTypes +ssh-rsa
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

    services.xserver = {
                enable = false;
                layout = "us";
                xkbOptions = "ctrl:nocaps";
                windowManager.xmonad.enable = false;
  };


}
