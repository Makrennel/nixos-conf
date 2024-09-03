{ config, lib, pkgs, ... }: {
  systemd.services.build-home = let
    username = lib.removeSuffix "\n" (builtins.readFile "${../variables/username}");
  in {
    enable = true;
    description = "Sets up a fresh home directory for the user if it is not present";
    serviceConfig.Type = "oneshot";
    wantedBy = [ "home-manager-${username}.service" ];
    before = [ "home-manager-${username}.service" ];
    path = with pkgs; [ mount ];
    script = ''
      [ ! -e /nix/persist/user ] && mkdir -p /nix/persist/user && chown -R 1000 /nix/persist/user && chgrp -R 100 /nix/persist/user
      if [ ! -d "/user" ]; then
        mkdir -p /home/{Desktop,Documents,Downloads,Images,Local,Music,Repositories,Shared,Templates,Videos}
        mkdir -p /user/{bin,cache,config,share,state,var}
        mkdir -p /user/{.bin,.cache,.config,.var}
        mkdir -p /user/share/{fonts,icons,themes}
        mkdir -p /user/{.fonts,.icons,.themes}

        chown -R 1000 /user /home
        chgrp -R 100 /user /home

        mount -B /user /home/Local

        mount -B /user/bin /user/.bin
        mount -B /user/cache /user/.cache
        mount -B /user/config /user/.config
        mount -B /user/var /user/.var

        mount -B /user/share/fonts /user/.fonts
        mount -B /user/share/icons /user/.icons
        mount -B /user/share/themes /user/.themes
      fi
    '';
  };

  systemd.services.use-tty6 = {
    enable = true;
    description = "Automatically switch to tty6 on boot";
    serviceConfig.Type = "simple";
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      kbd
    ];
    script = "chvt 6";
  };
}

