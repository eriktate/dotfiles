{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";

    zls.url = "github:zigtools/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zig, zls, ... }@inputs:
    let
      system = "x86_64-linux";
      zlspkg = zls.packages.${system};
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; overlays = [ zig.overlays.default ]; };
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; inherit zlspkg; inherit pkgs;};
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}
