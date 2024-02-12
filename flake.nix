{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # nonflake inputs
    pam-fprint-grosshack-src = {
      type = "gitlab";
      owner = "mishakmak";
      repo = "pam-fprint-grosshack";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, flake-utils, nixos-hardware
    , pam-fprint-grosshack-src, ... }@attrs:

    rec {
      platforms = [ "x86_64-linux" "x86_64-darwin" ];
      legacyPackages = nixpkgs.lib.genAttrs platforms (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.permittedInsecurePackages = [ "electron-25.9.0" ];
        });

      defaultPackage = nixpkgs.lib.genAttrs platforms (system:
        let p = legacyPackages."${system}";
        in p.writeScriptBin "run" ''
          HOSTNAME=$(hostname)
            sudo nixos-rebuild --flake ".#$HOSTNAME" $@
        '');

      nixosConfigurations = {
        v60 = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            (import ./system/hosts/v60/configuration.nix)

            sops-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dj = ./system/hosts/v60/home.nix;
            }
            nixos-hardware.nixosModules.framework-11th-gen-intel
          ];
        };

        kimchi = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            (import ./system/hosts/kimchi/configuration.nix)

            sops-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dj = ./system/hosts/kimchi/home.nix;
            }
          ];
        };
      };
    };
}
