{ config, inputs, lib, pkgs, ... }: {
  options.makrenos.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland Config";
    hyprscroller = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  imports = [
   inputs.hyprland.homeManagerModules.default
    ./execs.nix
    ./general.nix
    ./keybinds.nix
  ];

  config = lib.mkIf config.makrenos.hyprland.enable {
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.plugins = [
    ] ++ lib.optional config.makrenos.hyprland.hyprscroller pkgs.hyprlandPlugins.hyprscroller;
  };
}

