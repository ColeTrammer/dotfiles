{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options = {
    ags = {
      enable =
        lib.mkEnableOption "ags"
        // {
          default = config.desktop.enable;
        };
    };
  };

  config = lib.mkIf config.ags.enable {
    programs.ags = {
      enable = true;
    };

    # We can't use lib.mkOutOfStoreSymlink because we may need to perform custom logic here.
    home.activation = {
      updateAgs = ''
        export ROOT="${config.preferences.dotfilesPath}"
        mkdir -p .config
        rm -f .config/ags && ln -sf "$ROOT/home/desktop/ags" .config/ags
      '';
    };
  };
}
