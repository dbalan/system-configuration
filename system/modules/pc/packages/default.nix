{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> {};
  threema-desktop = pkgs.callPackage ./threema-desktop.nix { };
  roam-research = pkgs.callPackage ./roam-research.nix {  };

  kdepim = with pkgs; with plasma5Packages; [ # KDE Apps
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
    breeze-icons
    breeze-qt5
    gwenview
    kaddressbook
    kate
    kcalutils
    kdepim-addons
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
    konversation
    korganizer
    kpimtextedit
    krusader
    libkdepim
    libksieve
    mailcommon
    messagelib
    okular
    oxygen
    oxygen-icons5
    oxygenfonts
    pim-sieve-editor
    pimcommon
    redshift-plasma-applet
    spectacle
    digikam
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
    aws-sam-cli
    darktable
    #shotman
    slack
    sublime-music
  ];
  commonPackages = with pkgs; [
    # (pkgs.callPackage ./pipet.nix {})
    #(haskell.lib.justStaticExecutables (haskellPackages.callPackage ./idid.nix {}))
    #haskellPackages.arbtt
    amazon-ecr-credential-helper
    silver-searcher
    simple-scan
    awscli2
    ssm-session-manager-plugin
    bat
    beancount
    brave
    calibre
    discord
    docker-compose
    dolphin
    dunst
    evince
    exa
    easyeffects
    fava
    file
    fzf
    gcc
    gitAndTools.hub
    gnome.adwaita-icon-theme
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
    jq
    ldns
    libqalculate
    libsecret
    libnotify
    man-pages
    mpv
    msmtp
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
    sops
    steam
    stylish-haskell
    sublime-music
    ssm-session-manager-plugin
    tcpdump
    inetutils
    thunderbird
    tmux
    threema-desktop
    unzip
    vulkan-tools
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
    flameshot
    mdcat
    ncdu
    pcmanfm
  ];
in
{
  home.packages = commonPackages ++ unstablePackages ++ kdepim;
}

