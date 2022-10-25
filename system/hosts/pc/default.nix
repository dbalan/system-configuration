# common for pc
{ config, lib, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    "${(import ../../../nix/sources.nix).sops-nix}/modules/sops"
  ];

  nixpkgs.config.allowUnFreePredicate = p: builtins.elem (builtins.getName p) [
      "discord"
  ];

  hardware.enableRedistributableFirmware = true;

  # increase inotify limits for syncthing
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 204800; };

  networking.extraHosts =
    ''
    192.168.196.120 vault.ber.dbalan.in jellyfin.ber.dbalan.in home.ber.dbalan.in svc.ber.dbalan.in books.ber.dbalan.in
    192.168.196.70 photoprism.pvt.dbalan.in
    '' + builtins.readFile ../../../common-data/blocked.hosts;

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
    virt-manager
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

  virtualisation =  {
      libvirtd.enable = true;
      docker.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ 
        "FiraCode"
        "SourceCodePro"
        "Hack"
      ];
    })
    (iosevka.override {
      privateBuildPlan = ''
        [buildPlans.iosevka-custom]
        family = "Iosevka Custom"
        spacing = "normal"
        serifs = "sans"
        no-cv-ss = true
        export-glyph-names = false

        [buildPlans.iosevka-custom.variants]
        inherits = "ss02"

        [buildPlans.iosevka-custom.variants.design]
        capital-d = "more-rounded-serifless"
        capital-g = "toothless-corner-serifless-hooked"
        capital-q = "straight"
        f = "flat-hook"
        j = "flat-hook-serifed"
        l = "diagonal-tailed"
        t = "flat-hook"
        y = "straight-turn"
        long-s = "flat-hook"
        eszet = "longs-s-lig"
        lower-lambda = "straight-turn"
        cyrl-capital-ka = "straight-serifless"
        cyrl-ka = "straight-serifless"
        cyrl-capital-u = "straight-turn"
        one = "base"
        two = "straight-neck"
        four = "closed"
        six = "closed-contour"
        eight = "two-circles"
        nine = "closed-contour"
        asterisk = "hex-low"
        underscore = "low"
        brace = "straight"
        number-sign = "slanted"
        ampersand = "upper-open"
        percent = "rings-continuous-slash"
        bar = "force-upright"
        punctuation-dot = "square"
        diacritic-dot = "square"
    '';
    set = "custom";
    })
    fira-code
    fira
    source-code-pro
    hack-font

     noto-fonts
     emojione
     proggyfonts
     ibm-plex
     vollkorn
     merriweather
    noto-fonts-extra
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

  services.rpcbind.enable = false;
  services.emacs = {
    enable = true;
    #package = pkgs.emacsUnstable;
  };

  services.tailscale.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = ["233ccaac2757a496" "632ea29085fa00a5"];
  };

  services.avahi.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.upower.enable = true;

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
    }; in
    {
      "home-assistant-api" = {} // defopt;
      "github_token" = {} // defopt;
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
           gnupg.agent = {
             enable = true;
             enableSSHSupport = true;
             pinentryFlavor = "gtk2";
           };
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
             Host oldphotoprism
              Hostname 10.2.10.50
              User dj
              Port 22
              ProxyJump dj@ares.dbalan.in
             Host photoprism
              Hostname photoprism.pvt.dbalan.in
             '';
           light.enable = true;
           adb.enable = false;
  };

}
