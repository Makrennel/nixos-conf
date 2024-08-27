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
  };

  home.persistence."/nix/persist/user/applications" = {
    allowOther = true;
    removePrefixDirectory = true;
    directories = [
      "Floorp/.floorp"
      "Mozilla/.mozilla"
      { directory = "Steam/share/Steam"; method = "symlink"; }
    ];
  };
}
