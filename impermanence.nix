{ lib, pkgs, ... }: let
  persistent-directories = lib.lists.map (directory:
    "[ ! -e \"/btrfs_tmp/system${directory.directory}\" ] && mkdir -p /btrfs_tmp/system${directory.directory}\\n"
  ) config.environment.persistence."/nix/persist/system".directories;
  prepare-persistence = lib.concatStrings persistent-directories
in {
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/system/main /btrfs_tmp

    if [[ -e /btrfs_tmp/root ]]; then
      mkdir -p /btrfs_tmp/old
      timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
      mv /btrfs_tmp/root "/btrfs_tmp/old/$timestamp"
    fi

    delete_subvolume_recursively() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume_recursively "/btrfs_tmp/$i"
      done
      btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old/ -maxdepth 1 -mtime +30); do
      delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp

    # Fresh installation will fail to boot if we don't make sure the default persistent directories already exist
    mount -o subvol=/persist /dev/system/main /btrfs_tmp
    ${prepare-persistence}
    umount /btrfs_tmp
  '';
}
