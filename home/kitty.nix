{ config, lib, pkgs, ... }: {
  stylix.targets.kitty.enable = false;
  programs.kitty = {
    enable = true;
    font.name = "Jetbrains Mono";
    font.package = pkgs.jetbrains-mono;
    font.size = 12;
    theme = "Kanagawa";
    extraConfig = ''
      background_opacity 0.7
    '';
  };
}

