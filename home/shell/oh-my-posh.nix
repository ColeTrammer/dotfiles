{ config, lib, ... }:
{
  options = {
    shell.oh-my-posh = {
      enable = lib.mkEnableOption "oh-my-posh";
    };
  };

  config = lib.mkIf config.shell.oh-my-posh.enable {
    programs.oh-my-posh = {
      enable = true;
      settings = builtins.fromJSON (
        builtins.unsafeDiscardStringContext (builtins.readFile ./oh-my-posh.json)
      );
    };
  };
}
