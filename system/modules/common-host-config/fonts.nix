{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" "Hack" ]; })
    iosevka
    noto-fonts
    emojione
    proggyfonts
    ibm-plex
    vollkorn
    merriweather
    noto-fonts-extra
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" "Fira Code" "Hack" ];

}
