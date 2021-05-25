{ config, pkgs, ... }:

{
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
  
      Host mmbotserver 
         HostName 188.34.204.201
         User root
         RemoteForward 0.0.0.0:7357 127.0.0.1:7357

     '';
  };

}
