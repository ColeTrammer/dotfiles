{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.vscode.enable = lib.mkEnableOption "VS Code";
  };

  config = lib.mkIf config.apps.vscode.enable {
    home.packages = with pkgs; [ vscode-fhs ];

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".vscode";
          method = "symlink";
        }
        {
          directory = ".config/Code";
          method = "symlink";
        }
      ];
    };
  };
}
