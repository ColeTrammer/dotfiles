{
  lib,
  inputs,
  ...
}: let
  dirs = lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
  systems = builtins.attrNames dirs;
  getNames = system: builtins.attrNames (builtins.readDir ./${system});
  getName = path: builtins.head (builtins.split "\\." path);
  mkHome = system: path: let
    name = getName path;
  in {
    name = name;
    value = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs;};
      modules = [./${system}/${name}.nix];
    };
  };
  mkHomes = system: let names = getNames system; in builtins.map (mkHome system) names;
  homes = builtins.concatLists (builtins.map mkHomes systems);
in {
  flake = {
    homeConfigurations = builtins.listToAttrs homes;
  };
}
