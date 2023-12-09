{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host 10.0.*.*
        Port 8658
        user ubuntu

      Host 172.30.*.*
        Port 8658
        user ubuntu
    '';
  };

}
