{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  options = {
    shell.nix-index.enable = lib.mkEnableOption "nix-index" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.nix-index.enable {
    programs.nix-index = {
      enable = true;
    };
    programs.nix-index-database = {
      comma.enable = true;
    };
  };
}
