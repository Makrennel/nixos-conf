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
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, disko, home-manager, impermanence, stylix, systems, ... } @inputs: let
    inherit (nixpkgs) lib;
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    diskoConfigurations = eachSystem (system: import ./disko.nix);
    nixosConfigurations = eachSystem (system: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        disko.nixosModules.default
        (import ./disko.nix { device = builtins.readFile ./primary-disk; })
        #./hardware-configuration.nix
        {
          nixpkgs.hostPlatform = system;
        }

        home-manager.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

        impermanence.nixosModules.impermanence
        stylix.nixosModules.stylix

        ./env.nix
        ./general.nix
        ./impermanence.nix
        ./neovim.nix
        ./packages.nix
        ./persistence.nix
        ./services.nix
        ./shell.nix
        ./theme.nix
        ./users.nix
      ];
    });
  };
}
