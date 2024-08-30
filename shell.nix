{ config, lib, pkgs, ... }: {
  environment.loginShellInit = ''
    [ "$(tty)" = "/dev/tty6" ] && exec Hyprland || [ "$TERM" = "linux" ] && exec fbterm tmux
  '';

  environment.interactiveShellInit = ''
    [ "$(pwd)" = "$HOME" ] && cd $XDG_USER_HOME
    fastfetch
  '';

  environment.shellAliases = {
    cat = "bat";
    edit = "$EDITOR";
    v = "$EDITOR";
    lf = "ranger";
    ls = "eza";
    l = "eza -l";
    la = "eza -la";
    lg = "eza -lg";
    ll = "eza -lgo";
    lo = "eza -lo";

    config = "sudo nvim /nix/config";
    rebuild-switch = "sudo nixos-rebuild switch --flake /nix/config\\#default";
    rebuild-boot = "sudo nixos-rebuild boot --flake /nix/config\\#default";
    rebuild-build = "sudo nixos-rebuild build --flake /nix/config\\#default";
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "source ${pkgs.grml-zsh-config}/etc/zsh/zshrc";
  programs.zsh.promptInit = "";
  programs.zsh.setOptions = [
    "EMACS"
  ];
}

