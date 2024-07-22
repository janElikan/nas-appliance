{ config, pkgs, lib, ... }:

with lib;
{
  isoImage.edition = "minimal";
  isoImage.volumeID = "nas-appliance-system";
  isoImage.splashImage = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/waves/cat-waves.png";
    sha256 = "sha256-88xgdK/GwSG0F2afcFTQmljkxIByyQV5ROBDsY9nP1c=";
  };
  isoImage.efiSplashImage = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/waves/cat-waves.png";
    sha256 = "sha256-88xgdK/GwSG0F2afcFTQmljkxIByyQV5ROBDsY9nP1c=";
  };
  isoImage.appendToMenuLabel = " System";
  /*isoImage.contents = [
    { source = ""; target = "autofs"; }
  ];*/

  security.polkit.enable = mkForce false;
  services.openssh.enable = mkForce false;

  networking.wireless.enable = mkForce false;

  environment.etc."systemd/pstore.conf".text = mkForce "";
  environment.defaultPackages = mkForce [];

  services.getty.helpLine = mkForce ''
    Nas Appliance
    System version unavailable
    Unstable
  '';

  installer.cloneConfig = false;
}
