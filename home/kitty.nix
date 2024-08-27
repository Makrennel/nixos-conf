{ config, lib, pkgs, ... }: {
  stylix.targets.kitty.enable = false;
  programs.kitty = {
    enable = true;
    font.name = config.stylix.fonts.monospace.name;
    font.package = config.stylix.fonts.monospace.package;
    font.size = 12;
    theme = "Kanagawa";
    extraConfig = ''
      background_opacity 0.7
    '';
  };
}

