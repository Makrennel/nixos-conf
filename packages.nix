{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    eza
    fastfetch
    fbterm
    git
    kitty
    neovim
    nwg-drawer
    nwg-panel
    nix-output-monitor
    ranger
    tmux
    wget
  ];
}

