{ ... }: {
  imports = [
    ./fbterm.nix
    ./kitty.nix
    ./hyprland
    ./nwg
    ./waybar
  ];

  makrenos.hyprland.enable = true;

  home.stateVersion = "24.05";
}

