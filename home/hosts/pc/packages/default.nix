{ config, pkgs, ... }:

# FIXME: Make a system specific pkg list.

let
  unstable = import <unstable> {};
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
    kalarmcal
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
    xow
    awscli2
    ssm-session-manager-plugin
    droidcam
  ];  
  commonPackages = with pkgs; [
    # (pkgs.callPackage ./pipet.nix {})
    #(haskell.lib.justStaticExecutables (haskellPackages.callPackage ./idid.nix {}))
    #haskellPackages.arbtt
    ag
    alot
    anki
    ansible
    arandr
    awslogs
    bat
    beancount
    brave
    discord
    docker-compose
    dolphin
    dunst
    evince
    exa
    fava
    file
    firefox
    freerdp
    fzf
    gcc
    git-secret
    gitAndTools.hub
    gnome3.adwaita-icon-theme
    gnome3.meld
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
    manpages
    mpv
    msmtp
    morph
    neomutt
    nload
    nmap_graphical
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
    telnet
    thunderbird
    tmux
    tmux-cssh
    tree
    unzip
    vivaldi
    vulkan-tools
    wineWowPackages.full
    xmobar
    xorg.xhost
    zeal
    zoom-us
    zathura
    rtm.rtm-cli
  ];
in
{
  home.packages = commonPackages ++ unstablePackages ++ kdepim;
}

