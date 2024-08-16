{
  pkgs,
  device ? throw "Set this to the disk device you want to use, e.g. /dev/nvme0n1 or /dev/vda",
  efi-size ? "512M", # 1/2 a GiB by default 
  swap-size ? builtins.readFile (pkgs.runCommand "get-swap-size" {} "grep MemTotal /proc/meminfo | sed 's/[^0-9]*//g' | read mem; echo $mem'K' > $out"), # Same size as RAM by default
  main-size ? "100%", # Use 100% of remaining space by default
  ...
}: {
  disko.devices = {

    # Hardware Disk
    disk.main = {
      type = "disk";
      inherit device;
      content.type = "gpt";

      # I don't particularly care about old school BIOS - EFI only
      content.partitions.ESP = {
        size = efi-size;
        type = "EF00";
        content.type = "filesystem";
        content.format = "vfat";
        content.mountpoint = "/boot";
      };

      # Encrypted Partition with LVM volume inside
      content.partitions.luks = {
        size = "100%";
        content = {
          type = "luks";
          name = "vault";
          extraFormatArgs = [ "--type=luks2" "--pbkdf=argon2id" ];
          settings.allowDiscards = true;
          content = {
            type = "lvm_pv";
            vg = "system";
          };
        };
      };
    };


    # LVM Volumes
    lvm_vg.system = {
      type = "lvm_vg";

      lvs.swap = {
        size = swap-size;
        content.type = "swap";
        content.resumeDevice = true;
      };

      lvs.main = {
        size = main-size;
        content.type = "btrfs";
        content.subvolumes = {
          "/root".mountpoint = "/";
          "/nix".mountpoint = "/nix";
          "/nix".mountOptions = [ "noatime" ];
          "/persist".mountpoint = "/nix/persist";
          "/persist".mountOptions = [ "noatime" ];
          "/home".mountpoint = "/users";
          "/var".mountpoint = "/var";
          "/opt".mountpoint = "/opt";
          "/flatpak".mountpoint = "/var/lib/flatpak";
          "/libvirt".mountpoint = "/var/lib/libvirt";
        };
      };
    };
  };
}
