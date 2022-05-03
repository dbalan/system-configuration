# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  require = [
    ../pc
  ];

# nixpkgs.overlays = [(self: super: {
# libinput = super.libinput.overrideAttrs (_:  rec { version = "1.20.1";
#                                                name = "libinput-${version}";
#            				      	src = pkgs.fetchurl {
#          					      url = "https://gitlab.freedesktop.org/libinput/libinput/-/archive/${version}/${name}.tar.gz";
#                                                      sha256 = "0r40lpl1i5apm3r1a2q49b01227zhvdh7dvpq281f2pjbiffkgzv";
#                                                      };
# 	                                       });
# 	                                  
# 	                             })];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
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
  
  boot.initrd.availableKernelModules = [
    "aesni_intel"
    "cryptd"
  ];
  
  # enable deep sleep
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  
  networking.hostName = "v60"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

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

  services.tailscale.enable = true;
  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  users.users.dj = {
     isNormalUser = true;
     extraGroups = [ "wheel" "network" "wireshark"];
     description = "Dhananjay Balan";
     shell = pkgs.zsh;
  };

  home-manager.users.dj = ../../../home/hosts/v60/default.nix;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     mg # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 44721 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

