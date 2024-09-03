{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    chafa
    eza
    fastfetch
    fbterm
    floorp
    git
    htop
    keepassxc
    kitty
    mpv
    mullvad-browser
    neovim
    nwg-drawer
    nwg-panel
    nix-output-monitor
    pciutils
    qimgv
    ranger
    tmux
    wget
  ];
}

