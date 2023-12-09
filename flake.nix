{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

  };

  outputs = { self, nixpkgs, sops-nix, home-manager, flake-utils, ... }@attrs:

    rec {
      legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ]
        (system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          });

      nixosConfigurations = {
        v60 = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            (import ./system/hosts/v60/default.nix)

            sops-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dj =
                ./system/hosts/v60/home-config/default.nix;
            }
          ];
        };
      };
    };
}
