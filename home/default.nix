{ ... }: {
  imports = [
    ./fbterm.nix
    ./kitty.nix
    ./hyprland
    ./nwg
    ./persistence.nix
    ./shell.nix
    ./waybar
  ];

  makrenos.hyprland.enable = true;
  makrenos.hyprland.hyprscroller = true;

  home.stateVersion = "24.05";
}

