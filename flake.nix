{
  description = "Home Manager configuration of leon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-index-database, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            onedark-yazi = final.callPackage ./pkgs/onedark-yazi { };
            pond = final.callPackage ./pkgs/pond { };
            terminal-rain-lightning = final.callPackage ./pkgs/terminal-rain-lightning { };
            tetrs = final.callPackage ./pkgs/tetrs { };
          })
        ];
      };
    in
    {
      homeConfigurations."leon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          nix-index-database.homeModules.nix-index
          { programs.nix-index-database.comma.enable = true; }
          ./home.nix
        ];

        extraSpecialArgs = {
          vars = import ./vars.nix;
        };
      };
    };
}

