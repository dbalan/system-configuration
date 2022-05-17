{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> {};
  threema-desktop = pkgs.callPackage ./threema-desktop.nix { };
  rtm = import ./rtm-cli { inherit pkgs; };

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
    alot
    arandr
    awscli2
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
    fava
    file
    firefox
    fzf
    gcc
    git-secret
    gitAndTools.hub
    gnome3.adwaita-icon-theme
    meld
    gnome3.seahorse
    gnumake
    go
    godef
    gopass
    handbrake
    home-assistant-cli
    htop
    httpie
    imagemagick
    isync
    jq
    ldns
    libqalculate
    libsecret
    man-pages
    mpv
    msmtp
    morph
    neomutt
    w3m
    nload
    nmap-graphical
    notmuch
    obsidian
    p7zip
    pandoc
    python38Full
    python38Packages.ipython
    python38Packages.poetry
    python38Packages.qrcode
    python38Packages.virtualenv
    python38Packages.cfn-lint
    python-language-server
    rdesktop
    restic
    ripgrep
    rsync
    shutter
    skypeforlinux
    steam
    stylish-haskell
    sublime-music
    tcpdump
    inetutils
    thunderbird
    tmux
    tmux-cssh
    unzip
    vivaldi
    vulkan-tools
    wineWowPackages.full
    xorg.xhost
    zeal
    zoom-us
    zathura
    rtm.rtm-cli
    libreoffice
    wmname
    gopls
    haskellPackages.haskell-language-server
    threema-desktop
    terraform_0_14
    slack
    gh
    pinentry-gtk2
    ponymix
    xdg-utils
  ];
in
{
  home.packages = commonPackages ++ unstablePackages ++ kdepim;
}

