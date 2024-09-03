{ config, lib, pkgs, ... }: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
  stylix.image = "${pkgs.hyprland}/share/hypr/wall0.png";
  stylix.opacity.terminal = 0.7;

  stylix.fonts.monospace = {
    package = pkgs.nerdfonts;
    name = "Inconsolata";
  };
  stylix.fonts.serif = config.stylix.fonts.monospace;
  stylix.fonts.sansSerif = config.stylix.fonts.monospace;
  stylix.fonts.emoji = config.stylix.fonts.monospace;

  fonts.fontDir.enable = true;
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      # Icon Packages
      paths = with pkgs; [
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };

  fonts.packages = with pkgs; [
    inconsolata
    jetbrains-mono
    liberation_ttf
    nerdfonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-lgc-plus
    noto-fonts-monochrome-emoji
    #ricty
    sarasa-gothic
    unifont
  ];
}

