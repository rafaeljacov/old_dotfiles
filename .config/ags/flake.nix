{
  description = "AGS Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ags.url = "github:aylur/ags";
  };

  outputs = {
    self,
    nixpkgs,
    ags,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = ags.lib.bundle {
      inherit pkgs;
      src = ./.;
      name = "ags-shell"; # name of executable
      entry = "app.ts";
      gtk4 = false;

      # additional libraries and executables to add to gjs' runtime
      extraPackages = with ags.packages.${system}; [
        io
        hyprland
        battery
        mpris
        apps
        wireplumber
        tray
        notifd
        network
        bluetooth
      ];
    };
  };
}
