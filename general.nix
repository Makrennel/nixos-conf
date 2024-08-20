{ config, lib, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "isshiki-iroha";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_CA.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.variant = "mac";
  services.xserver.xkb.options = "caps:swapescape";

  hardware.graphics.enable = true;

  services.printing.enable = true;

  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?
}

