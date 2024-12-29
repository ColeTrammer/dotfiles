{ lib, inputs, ... }@args:
let
  dirs = lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
  hosts = builtins.attrNames dirs;
  mkConfig = host: {
    name = host;
    value = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        helpers = (import ../helpers) args;
      };
      modules = [ ./${host}/configuration.nix ];
    };
  };
  configs = builtins.map mkConfig hosts;
in
{
  flake = {
    nixosConfigurations = builtins.listToAttrs configs;
  };
}
