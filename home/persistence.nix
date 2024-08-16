{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/nix/persist/users/${config.home.username}" = {
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

  home.persistence."/nix/persist/users/${config.home.username}/applications" = {
    removePrefixDirectory = true;
    directories = [
      "Floorp/.floorp"
      "Mozilla/.mozilla"
      { directory = "Steam/share/Steam"; method = "symlink"; }
    ];
  };
}
