{ ... }: {
  imports = [
    ./fbterm.nix
    ./kitty.nix
    ./hyprland
    ./nwg
    ./persistence.nix
    ./qimgv.nix
    ./ranger.nix
    ./shell.nix
    ./waybar
  ];

  makrenos.hyprland.enable = true;
  makrenos.hyprland.hyprscroller = true;

  home.stateVersion = "24.05";
}

