{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> { };
  threema-desktop = pkgs.callPackage ./threema-desktop.nix { };
  roam-research = pkgs.callPackage ./roam-research.nix { };
  scmbreeze = pkgs.callPackage ./scmbreeze.nix { };

  kdepim = with pkgs;
    with plasma5Packages; [ # KDE Apps
      ark
      breeze-icons
      breeze-qt5
      gwenview
      kdialog
      okular
      oxygen
      oxygen-icons5
      oxygenfonts
      pim-sieve-editor
      pimcommon
      redshift-plasma-applet
      spectacle
      kidentitymanagement
      # End of KDE Apps
    ];
  unstablePackages = with unstable; [
    cabal-install
    ghc
    ghcid
    signal-desktop
    foliate
    spotify
    _1password-gui
    passage
    #aws-sam-cli
    #shotman
    slack
  ];
  commonPackages = with pkgs; [
    # (pkgs.callPackage ./pipet.nix {})
    #(haskell.lib.justStaticExecutables (haskellPackages.callPackage ./idid.nix {}))
    #haskellPackages.arbtt
    amazon-ecr-credential-helper
    silver-searcher
    simple-scan
    cmake
    awscli2
    bat
    brave
    bridge-utils
    blueberry
    calibre
    discord
    docker-compose
    darktable
    dolphin
    dunst
    evince
    exa
    easyeffects
    fava
    file
    fzf
    fluent-reader
    gcc
    gitAndTools.hub
    gnome.adwaita-icon-theme
    google-drive-ocamlfuse
    meld
    mullvad-vpn
    gnome.seahorse
    gnumake
    go
    godef
    gopass
    home-assistant-cli
    htop
    httpie
    imagemagick
    ispell
    jq
    ldns
    libqalculate
    libtool
    libsecret
    libnotify
    logseq
    man-pages
    mpv
    msmtp
    nixfmt
    w3m
    nload
    p7zip
    pandoc
    tree
    python39Full
    python39Packages.ipython
    python39Packages.qrcode
    python39Packages.virtualenv
    amazon-ecr-credential-helper
    #python-language-server
    restic
    roam-research
    ripgrep
    rsync
    #scmbreeze
    sops
    steam
    shellcheck
    shfmt
    stylish-haskell
    ssm-session-manager-plugin
    tcpdump
    inetutils
    thunderbird
    tmux
    unzip
    vulkan-tools
    vscode
    xorg.xhost
    zeal
    zoom-us
    zathura
    libreoffice
    libimobiledevice
    wmname
    gopls
    haskellPackages.haskell-language-server
    gh
    pinentry-gtk2
    ponymix
    xdg-utils
    mdcat
    ncdu
    pcmanfm
  ];
in { home.packages = commonPackages ++ unstablePackages ++ kdepim; }
