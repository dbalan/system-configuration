{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> { };

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
    roam-research
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
    unstable.eza
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
    btop
    sublime-music
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
<<<<<<< HEAD
<<<<<<< HEAD
    tree
=======
    lsd
=======
>>>>>>> dab4103 (New programs: lsd, wezterm)
    python39Full
    python39Packages.ipython
    python39Packages.qrcode
    python39Packages.virtualenv
>>>>>>> 5731e68 (update system config)
    amazon-ecr-credential-helper
    restic
    ripgrep
    rsync
    sops
    steam
    shellcheck
    shfmt
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
    zathura
    libreoffice
    libimobiledevice
    wmname
    gh
    pinentry-gtk2
    ponymix
    xdg-utils
    mdcat
    ncdu
    pcmanfm
  ];
in { home.packages = commonPackages ++ unstablePackages ++ kdepim; }
