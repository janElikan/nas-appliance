{
  description = "NAS Applicance";
  inputs.nixos.url = "nixpkgs/24.05";

  outputs = { self, nixos }: {
    nixosConfigurations.iso = nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixos}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./usb.nix
        ./appliance.nix
      ];
    };
  };
}
