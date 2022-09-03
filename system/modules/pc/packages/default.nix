{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> {};
  threema-desktop = pkgs.callPackage ./threema-desktop.nix { };

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
    kalarm
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
  ];  
  commonPackages = with pkgs; [
    # (pkgs.callPackage ./pipet.nix {})
    #(haskell.lib.justStaticExecutables (haskellPackages.callPackage ./idid.nix {}))
    #haskellPackages.arbtt
    silver-searcher
    simple-scan
    awscli2
    aws-sam-cli
    bat
    beancount
    brave
    calibre
    discord
    docker-compose
    dolphin
    dunst
    darktable
    evince
    exa
    fava
    file
    fzf
    gcc
    gitAndTools.hub
    gnome3.adwaita-icon-theme
    meld
    mullvad-vpn
    gnome3.seahorse
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
    man-pages
    mpv
    msmtp
    w3m
    nload
    p7zip
    pandoc
    passage
    tree
    python39Full
    python39Packages.ipython
    python39Packages.poetry
    python39Packages.qrcode
    python39Packages.virtualenv
    #python-language-server
    restic
    ripgrep
    rsync
    sops
    steam
    stylish-haskell
    sublime-music
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
    wmname
    gopls
    haskellPackages.haskell-language-server
    slack
    gh
    pinentry-gtk2
    ponymix
    xdg-utils
    flameshot
    mdcat
    pcmanfm
  ];
in
{
  home.packages = commonPackages ++ unstablePackages ++ kdepim;
}

