{ config, lib, pkgs, ... }:

{

  imports = [ ./fonts.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.enableRedistributableFirmware = true;

  # increase inotify limits for syncthing
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 204800; };

  # get systemd on boot (askpassword echo)
  boot.initrd.systemd.enable = true;

  networking.extraHosts = ""
    + builtins.readFile ../../../common-data/blocked.hosts;

  # Set your time zone.
  # use names from https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
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
    broadcom-bt-firmware
    curl
    gitAndTools.gitFull
    gnupg
    mg
    mosh
    nfs-utils
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

  # needed for sway.
  security.polkit.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # for steam
  hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true;

  # hardware keys
  hardware.nitrokey.enable = true;
  services.pcscd.enable = true;

  hardware.bluetooth.enable = true;
  # opengl
  hardware.opengl.enable = true;
  # logitech
  hardware.logitech.wireless = { enable = true; };

  # enable brother scanner
  hardware.sane = {
    enable = true;
    brscan4.enable = true;
  };

  # Rescue from HHKB
  services.udev.extraRules = ''
    ACTION=="remove", GOTO="hhkb_power_end"
    SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="Topre Corporation HHKB Professional", TAG-="power-switch"
    LABEL="hhkb_power_end"
  '';

  # update manager for fw
  services.fwupd.enable = true;
  services.dbus.packages = with pkgs; [ pkgs.dconf pkgs.blueman ];

  # enable mullvad
  services.mullvad-vpn.enable = true;

  services.smartd.enable = true;
  # services.physlock.enable = true;

  services.rpcbind.enable = false;
  services.emacs = {
    enable = true;
    # package = ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
    #  epkgs.emacs-libvterm
    #]));
  };

  services.tailscale.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "233ccaac2757a496" "632ea29085fa00a5" ];
  };

  services.avahi.enable = false;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  services.upower = { enable = true; };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # ios usb multiplexing, needed for tethering etc.
  services.usbmuxd.enable = true;

  sops.age.keyFile = "/home/dj/.config/sops/age/keys.txt";
  sops.secrets = let
    defopt = {
      mode = "0600";
      owner = config.users.users.dj.name;
      group = config.users.users.dj.group;
      sopsFile = ../../../secrets/common/common-secret.yaml;
    };
  in {
    "home-assistant-api" = { } // defopt;
    "github_token" = { } // defopt;
  };

  # For testing threema multidevice
  services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

    wireshark.enable = true;
    slock.enable = true;
    dconf.enable = true;
    wireshark.package = pkgs.wireshark;
    ssh.extraConfig = ''
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
      Host oldphotoprism
       Hostname 10.2.10.50
       User dj
       Port 22
       ProxyJump dj@ares.dbalan.in
      Host photoprism
       Hostname photoprism.pvt.dbalan.in
    '';
    light.enable = true;
    adb.enable = true;
  };

}
