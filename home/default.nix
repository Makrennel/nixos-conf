{ ... }: {
  imports = [
    ./fbterm.nix
    ./kitty.nix
    ./hyprland
    ./nwg
    ./waybar
  ];

  makrenos.hyprland.enable = true;
  makrenos.hyprland.hyprscroller = false;

  home.stateVersion = "24.05";
}

