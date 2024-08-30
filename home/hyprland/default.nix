{ config, inputs, lib, pkgs, ... }: {
  options.makrenos.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland Config";
    hyprscroller = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  imports = [
    ./execs.nix
    ./general.nix
    ./keybinds.nix
  ];

  config = lib.mkIf config.makrenos.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      plugins = [
      ] ++ lib.optional config.makrenos.hyprland.hyprscroller inputs.hyprscroller.packages.${pkgs.stdenv.hostPlatform.system}.hyprscroller;
    };
  };
}

