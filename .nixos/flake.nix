# /etc/nixos/flake.nix
{
  description = "flake for nixos";

  inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = { self, nixpkgs, yt-x }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}

