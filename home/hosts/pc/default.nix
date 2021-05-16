# common for pc
{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  programs.git = {
    enable = true;
    userName = "Dhananjay Balan";
    userEmail = "mail@dbalan.in";
  };

}
