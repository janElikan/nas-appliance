{ config, pkgs, lib, ... }:

{
  networking.hostName = "nas";
  networking.useNetworkd = true; # auto-configure networks
  networking.firewall.enable = false;
  systemd.network.wait-online.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    tmux
    htop
    strace
  ];

  services.autofs.enable = true;
  services.autofs.autoMaster = ''
    /mnt  /etc/autofs/auto.media  --timeout=0
  '';

  services.samba.enable = true;
  services.samba.shares = {
    shared = {
      path = "/mnt";
      browsable = "yes";
      "guest ok" = "yes";
      "read only" = "false";
    };
  };

  system.stateVersion = "24.05";
}
