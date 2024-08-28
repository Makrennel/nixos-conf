{ config, lib, pkgs, ... }: {
  environment.loginShellInit = ''
    [ "$(tty)" = "/dev/tty6" ] && exec Hyprland || [ "$TERM" = "linux" ] && exec fbterm tmux
  '';

  environment.interactiveShellInit = ''
    alias v="nvim"
    alias cat="bat"
    alias l="eza -l"
    alias la="eza -la"
    alias ll="eza -ll"
    alias lf="ranger"

    [ "$(pwd)" = "$HOME" ] && cd $XDG_USER_HOME

    fastfetch
  '';

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    eval "$(${pkgs.starship}/bin/starship init zsh)"
  '';
}

