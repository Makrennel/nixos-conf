{
  description = "MakrenOS Single-User System Configuration";

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
    getVar = varpath: lib.removeSuffix "\n" (builtins.readFile varpath);
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
          device = getVar "${./variables/disk}";
          efi-size = getVar "${./variables/efi-size}";
          main-size = getVar "${./variables/main-size}";
          swap-size = getvar "${./variables/swap-size}";
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
    templates.default = {
      path = "./";
      description = "MakrenOS Single-User System Configuration";
      welcomeText = ''
        This configuration is optimized for single user usage.
        The user directory is set to `/user`.
        User files should be stored in `/user/home`.

        The following variables must be set:
        `disk` - The disk you are installing on
        `password` - Your password in hashed form

        You can do so like this:
        ```
        $ echo "/dev/nvme0n1" | sudo tee variables/disk
        $ mkpasswd | sudo tee variables/password
        ```

        You may also want to change the following variables:
        `username` - Your choice of username (defaults to "alice")
        `efi-size` - The size of your EFI partition, mounted to /boot (defaults to 512M)
        `main-size` - The size of your primary BTRFS partition where data is stored (defaults to 100%FREE)
        `swap-size` - The size of your swap partition (defaults to 8G)

        ```
        $ echo "alice" | sudo tee variables/username
        $ echo "2G" | sudo tee variables/efi-size
        $ echo "1T" | sudo tee variables/main-size
        $ echo "20G" | sudo tee variables/swap-size
        ```
      '';
    };
  };
}
