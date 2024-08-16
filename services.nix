{ config, lib, pkgs, ... }: let
  use-tty6 = pkgs.writeShellScriptBin "use-tty6" "chvt 6";
in {
  systemd.services.use-tty6 = {
    enable = true;
    description = "Automatically switch to tty6 on boot";
    serviceConfig.Type = "simple";
    serviceConfig.ExecStart = "${use-tty6}/bin/use-tty6";
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      kbd
    ];
  };
}

