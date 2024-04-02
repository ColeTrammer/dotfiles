{
  lib,
  config,
  ...
}: {
  options = {
    shell.git = {
      enable =
        lib.mkEnableOption "Git"
        // {
          default = config.shell.enable;
        };

      gpgKey = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = ''The GPG key to use for signing commits (or the empty string to disable)'';
      };

      email = lib.mkOption {
        type = lib.types.str;
        default = "cole.trammer@gmail.com";
        description = ''Email address for git to use by default'';
      };

      username = lib.mkOption {
        type = lib.types.str;
        default = "ColeTrammer";
        description = ''Username for git to use by default'';
      };

      defaultBranch = lib.mkOption {
        type = lib.types.str;
        default = "main";
        description = ''Branch for git to use by default'';
      };

      github =
        lib.mkEnableOption "Setup GitHub CLI"
        // {
          default = true;
        };
    };
  };

  config = lib.mkIf config.shell.git.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      signing = {
        signByDefault = builtins.stringLength config.shell.git.gpgKey > 0;
        key =
          if (builtins.stringLength config.shell.git.gpgKey > 0)
          then config.shell.git.gpgKey
          else null;
      };
      userEmail = config.shell.git.email;
      userName = config.shell.git.username;
      extraConfig = {
        init.defaultBranch = config.shell.git.defaultBranch;
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase.autoStash = true;
      };
    };

    # Enable GitHub CLI for authenticatation
    programs.gh.enable = config.shell.git.github;
    home.file.".config/gh/hosts.yml" = lib.mkIf config.shell.git.github {
      text = ''
        github.com:
          git_protocol: https
          users:
            ${config.shell.git.username}
          user: ${config.shell.git.username}
      '';
    };
  };
}
