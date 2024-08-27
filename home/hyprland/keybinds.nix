{ config, lib, ... }: let
  # Keyboard Binds
  bind = [
    "SUPER, Return, exec, $TERMINAL"
    "SUPER CONTROL, Return, exec, $LAUNCHER"
    "SUPER SHIFT, Q, exit"

    "SUPER, G, fullscreen, 1" # Maximized
    "SUPER ALT, G, fullscreenstate, 1" # Maximized Client
    "SUPER CONTROL, G, fullscreenstate, 0" # None Client
    "SUPER, F, fullscreen, 0" # Fullscreen
    "SUPER ALT, F, fullscreenstate, 2" # Fullscreen Client
    "SUPER CONTROL, F, fullscreenstate, 3" # Both Fullscreen and Maximized

    "SUPER, D, killactive"
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
  # Mouse Binds
  bindm = [
    "SUPER, mouse:272, movewindow"
    "SUPER, mouse:273, resizewindow"
  ];
in {
  wayland.windowManager.hyprland.settings = lib.mkIf config.makrenos.hyprland.enable {
    inherit bind bindm;
  };
}

