{
  description = "Home Manager configuration of leon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-diff = {
      url = "github:pedorich-n/home-manager-diff";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pond = {
      url = "gitlab:alice-lefebvre/pond/1b74089f0d44f13efe8f695849d7cb8c7c6643de";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, home-manager-diff, pond, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            pond = prev.callPackage ./pond.nix { inherit pond; };
          })
        ];
      };
    in
    {
      homeConfigurations."leon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ home-manager-diff.hmModules.default ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
