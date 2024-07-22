{ config, pkgs, lib, ... }:

{
  networking.hostName = "nas";
  networking.useNetworkd = true; # auto-configure networks
  networking.firewall.enable = false;
  systemd.network.wait-online.enable = true;

  environment.systemPackages = with pkgs; [
    ldm
    vim
    tmux
    htop
    strace
  ];

  environment.etc."ldm.conf".text = ''
    MOUNT_OWNER=nixos
    BASE_MOUNTPOINT=/media
  '';

  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = true;

  systemd.services.autoMounter = {
    wantedBy = [ "multi-user.target" ];
    description = "The automount helper";
    serviceConfig = {
      ExecStart = "ldm -g=0 -u=0";
    };
  };

  services.samba.enable = true;
  services.samba.shares = {
    public = {
      path = "/media";
      browsable = "yes";
      "guest only" = "yes";
      "read only" = "no";
      "create mask" = "0666";
      "directory mask" = "0777";
    };
  };

  services.samba-wsdd = {
    enable = true;
    discovery = true;
  };

  system.stateVersion = "24.05";
}
