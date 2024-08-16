{ config, lib, ... }: let
  bind = [
    "SUPER, Return, exec, $TERMINAL"
    "SUPER CONTROL, Return, exec, $LAUNCHER"
    "SUPER SHIFT, Q, exit"

    "SUPER, D, killactive"
    "SUPER, F, fullscreen, 0"
    "SUPER, G, fullscreen, 1"
    "SUPER ALT, F, fakefullscreen, 0"
    "SUPER, C, togglefloating"
  ] ++ (builtins.concatLists (builtins.genList (x:
    let ws = let c = (x + 1) / 10;
    in builtins.toString (x + 1 - (c * 10)); in [
      "SUPER, ${ws}, workspace, ${toString (x + 1)}"
      "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
    ]
  ) 10)) ++ lib.lists.optionals config.makrenos.hyprland.hyprscroller [
    "SUPER, Tab, scroller:toggleoverview"
    "SUPER, I, scroller:cyclesize, next"
    "SUPER, Semicolon, scroller:admitwindow"
    "SUPER, Apostrophe, scroller:expelwindow"
    "SUPER, Y, scroller:setmode, c"
    "SUPER, U, scroller:setmode, r"
    "SUPER ALT, J, scroller:setmode, c"
    "SUPER ALT, L, scroller:setmode, r"

    "SUPER, H, scroller:movefocus, l"
    "SUPER, J, scroller:movefocus, d"
    "SUPER, K, scroller:movefocus, u"
    "SUPER, L, scroller:movefocus, r"

    "SUPER CONTROL, H, scroller:movewindow, l"
    "SUPER CONTROL, J, scroller:movewindow, d"
    "SUPER CONTROL, K, scroller:movewindow, u"
    "SUPER CONTROL, L, scroller:movewindow, r"

  ] ++ lib.lists.optionals (! config.makrenos.hyprland.hyprscroller) [
    "SUPER, H, movefocus, l"
    "SUPER, J, movefocus, d"
    "SUPER, K, movefocus, u"
    "SUPER, L, movefocus, r"

    "SUPER CONTROL, H, movewindow, l"
    "SUPER CONTROL, J, movewindow, d"
    "SUPER CONTROL, K, movewindow, u"
    "SUPER CONTROL, L, movewindow, r"
  ];
in { config.wayland.windowManager.hyprland.settings.bind = lib.mkIf config.makrenos.hyprland.enable bind; }

