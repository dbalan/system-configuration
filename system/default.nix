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

    };
  hostModules =
    builtins.listToAttrs (map (hostName: {
      name = hostName;
      value = makeHost (./hosts + "/${hostName}");
    }) (import ./hosts/all-hosts.nix));
in

hostModules
