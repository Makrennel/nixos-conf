{ config, lib, pkgs, ... }: let
  skeleton = pkgs.runCommand "user-skeleton" {} ''
    mkdir -p $out/home/{Desktop,Documents,Downloads,Local,Music,Images,Repositories,Shared,Templates,Videos} &&
    mkdir -p $out/{bin,cache,config,share,state,.var} &&
    mkdir -p $out/config/git &&
    mkdir -p $out/share/{fonts,icons,themes} &&
    ln -s .. $out/home/Local &&
  '';
in {
  security.pam.services.login.makeHomeDir = true;
  security.pam.makeHomeDir.skelDirectory = "${skeleton}";

  users.users = let
    createWheelUser = username: {
      home = "/users/${username}";
      createHome = false;
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "input" ];
      hashedPassword = lib.removeSuffix "\n" (builtins.readFile "${./passwords/${username}}"); # Default is 'password'
    };
  in {
    alice = createWheelUser "alice";
  };

  home-manager.users.alice = import ./homes/alice;
    
  home-manager.sharedModules = [
    ./home
    ({ config, lib, ... }: {
      home.homeDirectory = lib.mkForce "/users/${config.home.username}";

      home.file.".bin".source = lib.file.mkOutOfStoreSymlink "bin";
      home.file.".cache".source = lib.file.mkOutOfStoreSymlink "cache";
      home.file.".config".source = lib.file.mkOutOfStoreSymlink "config";
      home.file.".local".source = lib.file.mkOutOfStoreSymlink ".";
      home.file.".var".source = lib.file.mkOutOfStoreSymlink "var";

      home.file.".fonts".source = lib.file.mkOutOfStoreSymlink "share/fonts";
      home.file.".icons".source = lib.file.mkOutOfStoreSymlink "share/icons";
      home.file.".themes".source = lib.file.mkOutOfStoreSymlink "share/themes";

      xdg.cacheHome = "/users/${config.home.username}/cache";
      xdg.configHome = "/users/${config.home.username}/config";
      xdg.dataHome = "/users/${config.home.username}/share";
      xdg.stateHome = "/users/${config.home.username}/state";

      xdg.userDirs.enable = true;
      xdg.userDirs.desktop = "/users/${config.home.username}/home/Desktop";
      xdg.userDirs.documents = "/users/${config.home.username}/home/Documents";
      xdg.userDirs.pictures = "/users/${config.home.username}/home/Images";
      xdg.userDirs.music = "/users/${config.home.username}/home/Music";
      xdg.userDirs.publicShare = "/users/${config.home.username}/home/Shared";
      xdg.userDirs.templates = "/users/${config.home.username}/home/Templates";
      xdg.userDirs.videos = "/users/${config.home.username}/home/Videos";
      xdg.userDirs.extraConfig = {
        XDG_REPOSITORY_DIR = "/users/${config.home.username}/home/Repositories";
        XDG_USER_HOME = "/users/${config.home.username}/home";
        XDG_VAR_HOME = "/users/${config.home.username}/var";
        XDG_BIN_HOME = "/users/${config.home.username}/bin";
      };

      home.preferXdgDirectories = true;
    })
  ];
}

