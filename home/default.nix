{ ... }: {
  imports = [
    ./fbterm.nix
    ./kitty.nix
    ./hyprland
    ./nwg
    ./persistence.nix
    ./waybar
  ];

  makrenos.hyprland.enable = true;
  makrenos.hyprland.hyprscroller = false;

  home.stateVersion = "24.05";
}

