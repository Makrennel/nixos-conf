{ config, lib, pkgs, ... }: let
  skeleton = pkgs.runCommand "user-skeleton" {} ''
    mkdir -p $out/home/{Desktop,Documents,Downloads,Music,Images,Repositories,Shared,Templates,Videos} &&
    mkdir -p $out/{bin,cache,config,share,state,var} &&
    mkdir -p $out/{.fonts,.icons,.themes} &&
    ln -s .. $out/home/Local
  '';
  username = lib.removeSuffix "\n" (builtins.readFile "${./username}");
in {
  security.pam.services.login.makeHomeDir = true;
  security.pam.makeHomeDir.skelDirectory = "${skeleton}";

  users.users."${username}" = {
    home = "/user";
    createHome = false;
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "video" "input" ];
    hashedPassword = lib.removeSuffix "\n" (builtins.readFile "${./password}");
  };

  home-manager.users."${username}" = import ./home;
  home-manager.sharedModules = [
    ({ config, lib, ... }: {
      home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "bin";
      home.file.".cache".source = config.lib.file.mkOutOfStoreSymlink "cache";
      home.file.".config".source = config.lib.file.mkOutOfStoreSymlink "config";
      home.file.".local".source = config.lib.file.mkOutOfStoreSymlink ".";
      home.file.".var".source = config.lib.file.mkOutOfStoreSymlink "var";

      home.file."share/fonts".source = config.lib.file.mkOutOfStoreSymlink ".fonts";
      home.file."share/icons".source = config.lib.file.mkOutOfStoreSymlink ".icons";
      home.file."share/themes".source = config.lib.file.mkOutOfStoreSymlink ".themes";

      xdg.cacheHome = "${config.home.homeDirectory}/cache";
      xdg.configHome = "${config.home.homeDirectory}/config";
      xdg.dataHome = "${config.home.homeDirectory}/share";
      xdg.stateHome = "${config.home.homeDirectory}/state";

      xdg.userDirs.enable = true;
      xdg.userDirs.desktop = "${config.home.homeDirectory}/home/Desktop";
      xdg.userDirs.documents = "${config.home.homeDirectory}/home/Documents";
      xdg.userDirs.pictures = "${config.home.homeDirectory}/home/Images";
      xdg.userDirs.music = "${config.home.homeDirectory}/home/Music";
      xdg.userDirs.publicShare = "${config.home.homeDirectory}/home/Shared";
      xdg.userDirs.templates = "${config.home.homeDirectory}/home/Templates";
      xdg.userDirs.videos = "${config.home.homeDirectory}/home/Videos";
      xdg.userDirs.extraConfig = {
        XDG_REPOSITORY_DIR = "${config.home.homeDirectory}/home/Repositories";
        XDG_USER_HOME = "${config.home.homeDirectory}/home";
        XDG_VAR_HOME = "${config.home.homeDirectory}/var";
        XDG_BIN_HOME = "${config.home.homeDirectory}/bin";
      };

      home.preferXdgDirectories = true;
    })
  ];
}

