{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    eza
    fastfetch
    fbterm
    git
    htop
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

