{ config, lib, ... }: let
  exec-once = [
    "fcitx5"
#   "hyprctl setcursor Bibata-Modern-Classic 24"
    "nwg-panel"
#    "waybar"
  ];
in { wayland.windowManager.hyprland.settings.exec-once = lib.mkIf config.makrenos.hyprland.enable exec-once; }

