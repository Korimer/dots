{
  description = "Home Manager configuration of korimer";

  inputs = {
    import-tree.url = "github:denful/import-tree";

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, import-tree, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mkHome = user:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            (import-tree ./modules)
            (./peruser + "/${user}.nix")
          ];

          extraSpecialArgs =
            let
              splitUser = pkgs.lib.splitString "@" user;
              username = builtins.head splitUser;
              hostname = if builtins.length splitUser == 2
                then builtins.elemAt 1 splitUser
                else null;
            in
          {
            inherit inputs;
            userConfig = {
              inherit system;
              inherit username;
              inherit hostname;
            };
          };
        };
      allHomes = pkgs.lib.pipe ./peruser 
        [
          builtins.readDir
          builtins.attrNames
          (map (pkgs.lib.removeSuffix ".nix"))
          (map (name: pkgs.lib.nameValuePair name (mkHome name)))
          builtins.listToAttrs
        ]
      ;
    in
    {
      homeConfigurations = allHomes;
    };
}
