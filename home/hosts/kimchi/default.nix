{ config, pkgs, ... }:

let
  browsercat = import ./browsercat.nix {};
  unstable = import <unstable> {};

  kdepim = with pkgs; with kdeApplications; [ # KDE Apps
      akonadi
      akonadi-calendar
      akonadi-contacts
      akonadi-import-wizard
      akonadi-mime
      akonadi-notes
      akonadi-search
      akonadiconsole
      akregator
      ark
      gwenview
      kaddressbook
      kalarm
      kalarmcal
      kate
      kcalutils
      kdepim-addons
      kdepim-apps-libs
      kdepim-runtime
      kdialog
      kidentitymanagement
      kldap
      kmail
      kmailtransport
      kmbox
      kmime
      kmix
      kontact
      kontactinterface
      korganizer
      konversation
      kpimtextedit
      libkdepim
      libksieve
      mailcommon
      messagelib
      pimcommon
      pim-sieve-editor
      okular
      oxygen
      oxygen-icons5
      oxygenfonts
      redshift-plasma-applet
      spectacle
      # End of KDE Apps
  ];
in
{
  require = [
    ../pc
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dj";
  home.homeDirectory = "/home/dj";
  # overlays we would need
  # nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { version = "0.0.14"; src = builtins.fetchTarball "https://dl.discordapp.net/apps/linux/0.0.14/discord-0.0.14.tar.gz"; }); })];

  programs.zsh = {
    enable = true;
    shellAliases = {
      e = "emacsclient -t";
      ec = "emacsclient -c";
      mirc = "mosh -p 61000 irc";
      ns = "nix-shell";
      nsp = "nix-shell -p";
      cat = "bat";
      scp = "rsync -Pv";
      ls = "exa";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };

  programs.command-not-found.enable = true;
  programs.direnv = {
      enableZshIntegration = true;
      enable = true;
  };

  programs.kitty = {
     enable = true;
     font.name = "Fira Code";
     extraConfig =
      ''
      font_size 12
      enable_audio_bell no
      # theme monokai
      background #403e41
      foreground #fcfcfa

      cursor #fcfcfa
      cursor_text_color #000000
      selection_foreground #403e41
      selection_background #fcfcfa

      # dull black
      color0 #403e41
      # light black
      color8 #727072

      # dull red
      color1 #ff6188
      # light red
      color9 #ff6188

      # dull green
      color2 #a9dc76
      # light green
      color10 #a9dc76

      # yellow
      color3 #ffd866
      # light yellow
      color11 #ffd866

      # blue
      color4 #fc9867
      # light blue
      color12 #fc9867

      # magenta
      color5 #ab9df2
      # light magenta
      color13 #ab9df2

      # cyan
      color6 #78dce8
      # light cyan
      color14 #78dce8

      # dull white
      color7 #fcfcfa
      # bright white
      color15 #fcfcfa
      '';
  };

  home.sessionVariables = {
    EDITOR = "mg";
    ANSIBLE_STDOUT_CALLBACK = "debug";
  };

  programs.ssh = {
    enable = true;
    extraConfig =
      ''
       Host jmph
         Hostname 192.168.122.153
         User root
         IdentityFile /home/dj/.ssh/debian.temp0.dbalan.in.priv
       Host mastermaster
         Hostname 192.168.5.20
         User horizont
         ProxyJump jmph
       Host artsoft-ansible-lab
         HostName 88.198.200.83
         User root

       Host kali
         HostName 192.168.122.112
         User kali

       Host artsoft-meet1-lab
         HostName 49.12.104.19
         User root

      Host artsoft-meet2-lab
         HostName 88.198.200.70
         User root

      Host artsoft-vb1-lab
         HostName 88.198.200.85
         User root

      Host artsoft-vb2-lab
         HostName 168.119.56.212
         User root
     '';
  };

  home.packages = with pkgs; [
    anki
    pcmanfm
    openldap
    ansible
    jq
    dunst
    unstable.cabal-install
    llvmPackages.bintools
    gcc
    gnumake
    unstable.ghc
    unstable.ghcid
    telnet
    htop
    discord
    brave
    nload
    ldns
    mpv
    zeal
    bat
    go_1_15
    godef
    okular
    libqalculate
    steam
    isync
    neomutt
    gnome3.seahorse
    gnome3.meld
    libsecret
    msmtp
    gopass
    rambox
    thunderbird
    restic
    rsync
    sublime-music
    evince
    python38Full
    python38Packages.ipython
    python38Packages.poetry
    exa
    docker-compose
    zathura
    ag
    xmobar
    pandoc
    notmuch
    ripgrep
    alot
    fzf
    #haskellPackages.arbtt
    # (pkgs.callPackage ./pipet.nix {})
    browsercat.packages."browser-cat"
    gnome3.adwaita-icon-theme
    tmux-cssh
    tcpdump
    tmux
    httpie
    tree
    file
    #(haskell.lib.justStaticExecutables (haskellPackages.callPackage ./idid.nix {}))
    nmap_graphical
    skypeforlinux
    stylish-haskell
    zoom-us
    firefox
    freerdp
    wineWowPackages.full
    unstable.haskell-language-server
    shutter
    imagemagick
    git
    rdesktop
    manpages
    arandr
    beancount
    unstable.signal-desktop
    vulkan-tools
    lutris
    fava
    unstable.xow
    unzip
    xorg.xhost
    handbrake
    git-secret

    taffybar 
    breeze-qt5
    breeze-icons
  ] ++ kdepim;

  services.redshift = {
    enable = false;
    longitude = "13.404954";
    latitude = "52.520008";
  };
  services.status-notifier-watcher.enable = true;
  services.taffybar.enable = true;
  services.copyq.enable = true;
  services.dunst = {
    enable = true;
    settings = import ./dunstconf.nix;
  };
  programs.autorandr = {
    enable = true;
    profiles = {
      "ws" = {
        fingerprint = {
           DP-2 = "00ffffffffffff0010ace0404c31334126190104b5371f783a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539494133314c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819010a202020202020014602031cf14f90050403020716010611121513141f23091f0783010000023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a00000000000000000000000000000000000000000000000000000086";
           DP-1 = "00ffffffffffff0010ace1404c3838362619010380371f782a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539493638384c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819000a202020202020018a020324f14f90050403020716010611121513141f23091f078301000067030c001100383e023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a0000000000000000000000000000000000000081";
           HDMI-1 = "00ffffffffffff001e6d010001010101011e010380a05a780aee91a3544c99260f5054a1080031404540614071408180d1c00101010108e80030f2705a80b0588a0040846300001e662150b051001b304070360040846300001e000000fd0018781e873c000a202020202020000000fc004c4720545620535343520a202001e402034ff15a6160101f66650413051403021220212215015d5e5f6263643f40290957071507505507006e030c001000b83c2400800102030468d85dc40178800302e200cfe305c000e3060d01e20f33565e00a0a0a029503020350040846300001e000000000000000000000000000000000000000000000000000000000000f3";
        };
        config = {
          HDMI-1 = {
            enable = false;
          };
          DP-1 = {
            enable = true;
            mode = "2560x1440";
            position = "0x843";
            primary = true;
          };
          DP-2 = {
            enable = true;
            mode = "2560x1440";
            position = "2560x0";
            rotate = "left";
          };
        };
      };
      "qs" = {
        fingerprint = {
           DP-2 = "00ffffffffffff0010ace0404c31334126190104b5371f783a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539494133314c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819010a202020202020014602031cf14f90050403020716010611121513141f23091f0783010000023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a00000000000000000000000000000000000000000000000000000086";
           DP-1 = "00ffffffffffff0010ace1404c3838362619010380371f782a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539493638384c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819000a202020202020018a020324f14f90050403020716010611121513141f23091f078301000067030c001100383e023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a0000000000000000000000000000000000000081";
           HDMI-1 = "00ffffffffffff001e6d010001010101011e010380a05a780aee91a3544c99260f5054a1080031404540614071408180d1c00101010108e80030f2705a80b0588a0040846300001e662150b051001b304070360040846300001e000000fd0018781e873c000a202020202020000000fc004c4720545620535343520a202001e402034ff15a6160101f66650413051403021220212215015d5e5f6263643f40290957071507505507006e030c001000b83c2400800102030468d85dc40178800302e200cfe305c000e3060d01e20f33565e00a0a0a029503020350040846300001e000000000000000000000000000000000000000000000000000000000000f3";
        };
        config = {
          HDMI-1 = {
            enable = false;
          };
          DP-1 = {
            enable = true;
            mode = "2560x1440";
            position = "0x843";
            primary = true;
          };
          DP-2 = {
            enable = true;
            mode = "2560x1440";
            position = "2560x0";
          };
        };
      };
      "tv" = {
        fingerprint = {
           DP-2 = "00ffffffffffff0010ace0404c31334126190104b5371f783a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539494133314c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819010a202020202020014602031cf14f90050403020716010611121513141f23091f0783010000023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a00000000000000000000000000000000000000000000000000000086";
           DP-1 = "00ffffffffffff0010ace1404c3838362619010380371f782a55c5af4f33b8250b5054a54b00714fa9408180d1c00101010101010101565e00a0a0a029503020350029372100001a000000ff00334a5634303539493638384c0a000000fc0044454c4c20555032353136440a000000fd00324b1e5819000a202020202020018a020324f14f90050403020716010611121513141f23091f078301000067030c001100383e023a801871382d40582c450029372100001e7e3900a080381f4030203a0029372100001a011d007251d01e206e28550029372100001ebf1600a08038134030203a0029372100001a0000000000000000000000000000000000000081";
           HDMI-1 = "00ffffffffffff001e6d010001010101011e010380a05a780aee91a3544c99260f5054a1080031404540614071408180d1c00101010108e80030f2705a80b0588a0040846300001e662150b051001b304070360040846300001e000000fd0018781e873c000a202020202020000000fc004c4720545620535343520a202001e402034ff15a6160101f66650413051403021220212215015d5e5f6263643f40290957071507505507006e030c001000b83c2400800102030468d85dc40178800302e200cfe305c000e3060d01e20f33565e00a0a0a029503020350040846300001e000000000000000000000000000000000000000000000000000000000000f3";
        };
        config = {
          HDMI-1 = {
            enable = true;
            mode = "3840x2160";
            position = "0x0";
            primary = true;
          };
          DP-1 = {
            enable = true;
            mode = "2560x1440";
            position = "0x0";
          };
          DP-2 = {
            enable = false;
          };
        };
      };
    };
  };


  services.syncthing.enable = true;

  # set HiDPI hints -- run xrdb -merge ~/.Xresources if changes.
  home.file.".Xresources".source = "/home/dj/.config/nixpkgs/hidpi-xresources";
  home.file.".Xresources".onChange = ''
    echo "Re-merging xresources"
    $DRY_RUN_CMD xrdb -merge ~/.Xresources
  '';

  # configure alacritty
  home.file.".config/alacritty/alacritty.yml".source = "/home/dj/.config/nixpkgs/alacritty.yml";

  # configure stylish-haskell
  home.file.".stylish-haskell.yml".source = "/home/dj/.config/nixpkgs/stylish-haskell.yml";

  home.file.".arbtt/categorize.cfg".source = "/home/dj/.config/nixpkgs/arbtt-config.cfg";

  gtk.enable = true;
  gtk.iconTheme.name = "Adwaita";

  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = self: [ self.taffybar ];
    config = pkgs.writeText "xmonad.hs" (builtins.readFile "/home/dj/.config/nixpkgs/xmonad.hs");
  };

  home.file.".config/taffybar/taffybar.hs" = {
    source = "/home/dj/.config/nixpkgs/taffybar.hs";
    onChange = ''
        rm /home/dj/.cache/taffybar/taffybar-linux-x86_64
        systemctl --user restart taffybar
    '';
  };
     
  # configure xmobar
  #home.file.".xmonad/xmobar.config".source = "/home/dj/.config/nixpkgs/xmobar.config";
  #home.file.".xmonad/xmobar.config".onChange = ''
  #echo "restart xmonad"
  #xmonad --restart
  #'';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
