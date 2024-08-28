Single user focused config

Installation:

Partition your disk using disko
```
sudo nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko --flake github:Makrennel/nixos-conf#default --argstr device "/dev/YOUR_DISK"
```
You can change the following partition sizes:
```
--argstr efi-size "512M"
--argstr main-size "100%FREE"
--argstr swap-size "8G"
```
Once the disk is partitioned, generate a normal config in `/nix/config`:
```
sudo nixos-generate-config --no-filesystems --root /mnt --dir /mnt/nix/config
```
Initialize Flake, using this repository's template:
```
cd /mnt/nix/config
sudo nix --experimental-features 'nix-command flakes' flake init -t github:Makrennel/nixos-conf#default
```
Set variables (If you changed any partition sizes, you should do so here as well):
Mandatory variables:
```
disk - $ echo "/dev/YOUR_DISK" | sudo tee variables/disk
password - $ mkpasswd | sudo tee variables/password
```
Other Variables:
```
username - $ echo "alice" | sudo tee variables/username
efi-size - $ echo "512M" | sudo tee variables/efi-size
main-size - $ echo "100%FREE" | sudo tee variables/main-size
swap-size - $ echo "8G" | sudo tee variables/swap-size
```
Finally, install system:
```
sudo nixos-install --root /mnt --flake /mnt/nix/config#default --no-root-passwd
```
