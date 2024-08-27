{ config, lib, ... }: {
  wayland.windowManager.hyprland.settings = lib.mkIf config.makrenos.hyprland.enable {
    input = {
      kb_layout = "gb";
      kb_variant = "mac";
      kb_options = "caps:swapescape";
      repeat_rate = 150;
      repeat_delay = 250;

      sensitivity = -0.8;
      accel_profile = "flat";
      
      follow_mouse = 2;
      float_switch_override_focus = 0;
    };

    decoration = {
      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0;
      rounding = 20;
      shadow_ignore_window = true;
      shadow_range = 20;
      shadow_offset = "0 2";
      shadow_render_power = "4";
    };

    decoration.blur = {
      enabled = true;
      xray = true;
      special = false;
      new_optimizations = true;
      size = 3;
      passes = 3;
      brightness = 1;
      noise = 0.01;
      contrast = 1;
      popups = true;
      popups_ignorealpha = 0.6;
    };

    general = {
      gaps_in = 4;
      gaps_out = 12;

      "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base05})";
      
      border_size = 4;
      layout = lib.mkIf config.makrenos.hyprland.hyprscroller "scroller";
    };

    misc = {
      new_window_takes_over_fullscreen = 1;
      exit_window_retains_fullscreen = true;
    };

    plugins.scroller = lib.mkIf config.makrenos.hyprland.hyprscroller {
      column_default_width = "onehalf";
      focus_wrap = false;
    };
  };
}

