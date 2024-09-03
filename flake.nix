{
  description = "MakrenOS Single-User System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence/create-persistent-storage-dirs";
    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=918d8340afd652b011b937d29d5eea0be08467f5";
    hyprscroller.url = "github:dawsers/hyprscroller/4121019cde46c80fce78cf985a4bb8a04f74712e";
    hyprscroller.inputs.hyprland.follows = "hyprland";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, disko, ... } @inputs: let
    getVar = varpath: nixpkgs.lib.removeSuffix "\n" (builtins.readFile varpath);
  in {
    diskoConfigurations.default = import ./system/disko.nix;
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        inputs.stylix.nixosModules.stylix

        (import ./system/disko.nix {
          device = getVar "${./variables/disk}";
          efi-size = getVar "${./variables/efi-size}";
          main-size = getVar "${./variables/main-size}";
          swap-size = getVar "${./variables/swap-size}";
        })

        ./hardware-configuration.nix
        ./system/general.nix # Equivalent to configuration.nix

        ./system/env.nix
        ./system/impermanence.nix
        ./system/neovim.nix
        ./system/packages.nix
        ./system/persistence.nix
        ./system/services.nix
        ./system/shell.nix
        ./system/theme.nix
        ./system/user.nix

        {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

        { # Extra Binary Caches
          nix.settings.substituters = [
            "https://hyprland.cachix.org"
          ];
          nix.settings.trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
        }
      ];
    };
    templates.default = {
      path = ./.;
      description = "MakrenOS Single-User System Configuration";
      welcomeText = ''
        ## This configuration is optimized for single user usage.
        ## The user directory is set to `/user`.
        ## User files should be stored in `/user/home`.

        ## The following variables must be set:
        - `disk` - The disk you are installing on
        - `password` - Your password in hashed form

        ## You can do so like this:
        ```
        - $ echo "/dev/nvme0n1" | sudo tee variables/disk
        - $ mkpasswd | sudo tee variables/password
        ```

        ## You may also want to change the following variables:
        - `username` - Your choice of username (defaults to "alice")
        - `efi-size` - The size of your EFI partition, mounted to /boot (defaults to 512M)
        - `main-size` - The size of your primary BTRFS partition where data is stored (defaults to 100%FREE)
        - `swap-size` - The size of your swap partition (defaults to 8G)

        ```
        - $ echo "alice" | sudo tee variables/username
        - $ echo "2G" | sudo tee variables/efi-size
        - $ echo "1T" | sudo tee variables/main-size
        - $ echo "20G" | sudo tee variables/swap-size
        ```
      '';
    };
  };
}
