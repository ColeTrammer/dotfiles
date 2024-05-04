{
  config,
  lib,
  inputs,
  pkgs,
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

  config = let
    ags-config = pkgs.buildNpmPackage {
      pname = "coletrammer-ags-config";
      version = "0.0.1";

      src = ./.;

      npmDepsHash = "sha256-SW4nQZ3rONKnYSGMBmj7mPBF3NFIxysp5nPSXiVPs3M=";

      postPatch = ''
        cp -r ${config.programs.ags.package}/share/com.github.Aylur.ags/types .
      '';
    };
  in
    lib.mkIf config.ags.enable {
      programs.ags = {
        enable = true;
      };

      xdg.configFile."ags".source = "${ags-config}/lib/node_modules/coletrammer-ags-dotfiles";

      # Autostart AGS.
      systemd.user.services.ags = {
        Unit = {
          Description = "AGS";
          After = ["graphical-session-pre.target"];
        };

        Service = {
          ExecStart = "${config.programs.ags.package}/bin/ags";
          ExecStop = "${pkgs.coreutils}/bin/kill -SIGTERM $MAINPID";
          Restart = "on-failure";
        };

        Install.WantedBy = ["default.target"];
      };

      # We can't use lib.mkOutOfStoreSymlink because of a nix unstable issue.
      # see https://github.com/nix-community/home-manager/issues/4692
      # This sets up the dev env with a symlink to the correct AGS types.
      home.activation = {
        updateAgsTypes = ''
          output="${config.preferences.dotfilesPath}/home/desktop/ags/types"
          rm -f $output && ln -sf ${config.programs.ags.package}/share/com.github.Aylur.ags/types $output
        '';
      };

      # For now, enable these servies. In the future this can be taken care of directly by AGS.
      services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;
      };
    };
}
