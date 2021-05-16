# # !!! This file belongs to the yarn framework. !!!
# # !!! Do not change unless you know what you're doing. !!!

let
  # This function takes the path of a device module as an argument
  # and returns a complete module to be imported in configuration.nix
  makeHost = 
    hostPath:
    { config, pkgs, lib, options, ... }:

    {
      imports = [
        # ...the device module holding the system configuration...
        hostPath
      ]; # ...and all the extra modules.

      #nix.nixPath = options.nix.nixPath.default ++ [
        # Where to get the top-level nix file, i.e. this one
       # "nixos-config=/etc/nixos/configuration.nix"
        # The channel to be subscribed on
        
      #];
    };
  hostModules =
    builtins.listToAttrs (map (hostName: {
      name = hostName;
      value = makeHost (./hosts + "/${hostName}");
    }) (import ./hosts/all-hosts.nix));
in

hostModules
