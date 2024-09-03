{ config, lib, pkgs, ... }: let
  username = lib.removeSuffix "\n" (builtins.readFile "${../variables/username}");
in {
  users.users."${username}" = {
    home = "/user";
    createHome = false; # Home Directory is created in services.nix
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "video" "input" ];
    hashedPassword = lib.removeSuffix "\n" (builtins.readFile "${../variables/password}");
  };

  home-manager.users."${username}" = import ./home;
  home-manager.sharedModules = [
    ({ config, lib, ... }: {
      home.file."home".source = config.lib.file.mkOutOfStoreSymlink "/home";
      home.file.".local".source = config.lib.file.mkOutOfStoreSymlink "/user";

      xdg.cacheHome = "/user/cache";
      xdg.configHome = "/user/config";
      xdg.dataHome = "/user/share";
      xdg.stateHome = "/user/state";

      xdg.userDirs.enable = true;
      xdg.userDirs.desktop = "/home/Desktop";
      xdg.userDirs.documents = "/home/Documents";
      xdg.userDirs.download = "/home/Downloads";
      xdg.userDirs.pictures = "/home/Images";
      xdg.userDirs.music = "/home/Music";
      xdg.userDirs.publicShare = "/home/Shared";
      xdg.userDirs.templates = "/home/Templates";
      xdg.userDirs.videos = "/home/Videos";
      xdg.userDirs.extraConfig = {
        XDG_REPOSITORY_DIR = "/home/Repositories";
        XDG_USER_HOME = "/home";
        XDG_VAR_HOME = "/user/var";
        XDG_BIN_HOME = "/user/bin";
      };

      home.preferXdgDirectories = true;
    })
  ];
}

