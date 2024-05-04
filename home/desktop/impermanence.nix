{
  config,
  lib,
  ...
}: {
  options = {
    desktop.impermanence.enable =
      lib.mkEnableOption "impermanence"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.impermanence.enable {
    home.persistence."/persist/home" = {
      directories = [
        ".cache"
        {
          directory = ".ccache";
          method = "symlink";
        }
        {
          directory = "Downloads";
          method = "symlink";
        }
        {
          directory = "Music";
          method = "symlink";
        }
        {
          directory = "Pictures";
          method = "symlink";
        }
        {
          directory = "Documents";
          method = "symlink";
        }
        {
          directory = "Videos";
          method = "symlink";
        }
        {
          directory = "Workspace";
          method = "symlink";
        }
      ];
      allowOther = true;
    };

    # Automatically create missing directories in the persist directory:
    # See: https://github.com/nix-community/impermanence/issues/177
    home.activation.createTargetFileDirectoriesFixup = let
      isSymlink = entry: (!lib.isString entry) && (entry.method == "symlink");
      entryPath = entry:
        if lib.isString entry
        then entry
        else entry.directory;

      cfg = config.home.persistence;

      persistenceRoots = lib.attrNames cfg;
      mkdirPersistentLocations =
        map (
          root: let
            persistentDirectories =
              # Collect all directories which are symlinks
              (map entryPath (lib.filter isSymlink cfg.${root}.directories))
              ++
              # And all directories of files
              (map dirOf (map entryPath (cfg.${root}.files)));

            completePaths = map (path: lib.path.append (/. + root) path) persistentDirectories;
            mkdirCommands = lib.concatMapStrings (completePath: "run mkdir -p ${lib.escapeShellArg completePath}\n") completePaths;
          in ''
            # mkdir's for ${root}

            ${mkdirCommands}
          ''
        )
        persistenceRoots;
    in
      config.lib.dag.entryBetween ["writeBoundary"] ["createTargetFileDirectories"] (
        lib.concatMapStrings (cmds: "${cmds}\n") mkdirPersistentLocations
      );
  };
}
