{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/nix/persist/user" = {
    allowOther = true;
    directories = [
      "bin"
      "share/keyrings"
      "share/direnv"
      "share/fonts"
      "share/icons"
      "share/themes"
      "var"
    ];
    files = [
      "state/zsh-history"
    ];
  };

  home.persistence."/nix/persist/user/applications" = {
    allowOther = true;
    removePrefixDirectory = true;
    directories = [
      "Floorp/.floorp"
      "Mozilla/.mozilla"
      "nwg-shell/config/nwg-panel"
      "nwg-shell/share/nwg-panel"
      { directory = "Steam/share/Steam"; method = "symlink"; }
    ];
  };
}
