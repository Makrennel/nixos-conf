{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/nix/persist/user" = {
    directories = [
      "bin"
      "home"
      "share/keyrings"
      "share/direnv"
      "share/fonts"
      "share/icons"
      "share/themes"
      "var"
    ];
  };

  home.persistence."/nix/persist/user/applications" = {
    removePrefixDirectory = true;
    directories = [
      "Floorp/.floorp"
      "Mozilla/.mozilla"
      { directory = "Steam/share/Steam"; method = "symlink"; }
    ];
  };
}
