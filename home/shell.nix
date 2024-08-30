{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    dotDir = "config/zsh";
    history.path = "${config.xdg.stateHome}/zsh-history";
  };
}
