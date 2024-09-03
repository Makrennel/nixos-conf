{ config, lib, ... }: let
  windowrule = [
  ];
  layerrule = [
    "noanim, noanim"
    "blur, gtk-layer-shell"
    "ignorezero, gtk-layer-shell"
    "blur, launcher"
    "ignorealpha 0.5, launcher"
    "blur, notifications"
    "ignorealpha 0.69, notifications"
  ];
in {
  wayland.windowManager.hyprland.settings = lib.mkIf config.makrenos.hyprland.enable {
    inherit windowrule layerrule;
  };
}

