{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
#    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1&ref=v0.41.0";
#    hyprscroller.url = "github:dawsers/hyprscroller";
#    hyprscroller.inputs.hyprland.follows = "hyprland";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, disko, ... } @inputs: let
    inherit (nixpkgs) lib;
  in {
    diskoConfigurations.default = import ./disko.nix;
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        inputs.stylix.nixosModules.stylix

        (import ./disko.nix {
          device = ;
          efi-size = "512M";
          main-size = "100%FREE";
          swap-size = "8G";
        })

        ./hardware-configuration.nix

        ./env.nix
        ./general.nix
        ./impermanence.nix
        ./neovim.nix
        ./packages.nix
        ./persistence.nix
        ./services.nix
        ./shell.nix
        ./theme.nix
        ./user.nix

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
