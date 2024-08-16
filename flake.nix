{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
#    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1";
#    hyprscroller.url = "github:dawsers/hyprscroller";
#    hyprscroller.inputs.hyprland.follows = "hyprland";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.disko.nixosModules.default
        (import ./disko.nix { device = "/dev/nvme0n1"; efi-size = "2G"; main-size = "1T"; swap-size = "24G"; })
        #./hardware-configuration.nix

        inputs.home-manager.nixosModules.default
        {
          inputs.home-manager.useGlobalPkgs = true;
          inputs.home-manager.useUserPackages = true;
          inputs.home-manager.extraSpecialArgs = { inherit inputs; };
        }

        inputs.impermanence.nixosModules.impermanence
        inputs.stylix.nixosModules.stylix

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
    };
  };
}
