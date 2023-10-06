# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ../../modules/retiolum/default.nix
  ];

  require = [ ../pc ];

  nixpkgs.config.allowUnFreePredicate = p:
    builtins.elem (builtins.getName p) [ "discord" ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
    # Grub menu is painted really slowly on HiDPI, so we lower the
    # resolution. Unfortunately, scaling to 1280x720 (keeping aspect
    # ratio) doesn't seem to work, so we just pick another low one.
    gfxmodeEfi = "1024x768";
  };

  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/551fe16a-1bd1-4287-958a-c4947fc6a901";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.initrd.availableKernelModules = [ "aesni_intel" "cryptd" ];

  # enable deep sleep
  boot.kernelParams = [ "i915.enable_psr=0" "mem_sleep_default=deep" ];
  #boot.kernelPackages = pkgs.linuxPackages_5_19;

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  networking.hostName = "v60"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.fprintd.enable = false;
  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  programs.zsh.enable = true;
  users.users.dj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "network" "wireshark" "docker" "libvirtd" ];
    description = "Dhananjay Balan";
    shell = pkgs.zsh;
  };

  home-manager.users.dj = ./home-config/default.nix;

  environment.systemPackages = with pkgs;
    [
      mg # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gtk2";
  };

  # List services that you want to enable:

  # setup secrets
  sops.defaultSopsFile = ../../../secrets/v60/secrets.yaml;
  sops.age.keyFile = "/home/dj/.config/sops/age/keys.txt";
  sops.secrets = let
    defopt = {
      mode = "0600";
      owner = config.users.users.dj.name;
      group = config.users.users.dj.group;
    };
  in {
    backup = { } // defopt;
    "wireguard/ares_dbalan_in" = { } // defopt;
    "retiolum/ed25519_key.priv" = { } // defopt;
    "retiolum/rsa_key.priv" = { } // defopt;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  security.pam.services.swaylock = { };

  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';

  #environment.sessionVariables.NIXOS_OZONE_WL= "1";

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 9090 ];
    allowPing = true;
  };

  # connect to krebs vpn
  # networking.retiolum.ipv4 = "10.243.42.12";
  # networking.retiolum.ipv6 = "42:0:3c46:a24:a2de:502c:b037:79ab";
  # services.tinc.networks.retiolum = {
  #     rsaPrivateKeyFile = config.sops.secrets."retiolum/rsa_key.priv".path;
  #     ed25519PrivateKeyFile = config.sops.secrets."retiolum/ed25519_key.priv".path;
  # };

  # connect to my overlay
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "192.168.40.2/24" ];
      privateKeyFile = config.sops.secrets."wireguard/ares_dbalan_in".path;
      peers = [{
        publicKey = "a2cwNbB9hrcjWlLE+iSrywrcQfgX53Nlt/kuAokqChU=";
        allowedIPs = [
          "192.168.40.1/32"
          "192.168.40.0/24"
          "192.168.31.0/24"
          "10.11.11.0/24"
          "10.1.10.0/24"
          "10.2.10.0/24"
        ];
        endpoint = "ares.dbalan.in:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  # backup - voltus device, data in voltus
  services.restic.backups = {
    backup = {
      user = "dj";
      repository = "s3://s3.amazonaws.com/dbalan-backups/v60";
      passwordFile = config.sops.secrets.backup.path;
      paths = [ "/home/dj" ];
      extraBackupArgs = [
        "--exclude-file=/home/dj/code/private/system-configuration/common-data/v60.exclude"
        "--exclude-caches"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

