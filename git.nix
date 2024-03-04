{ lib, config, ... }:

{
  options = {
    gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''The GPG key to use for signing commits (or the empty string to disable)'';
    };
  };

  config = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      signing = {
        signByDefault = builtins.stringLength config.gpgKey > 0;
        key = if (builtins.stringLength config.gpgKey > 0) then config.gpgKey else null;
      };
      userEmail = "cole.trammer@gmail.com";
      userName = "ColeTrammer";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase.autoStash = true;
      };
    };

    # Enable GitHub CLI for authenticatation
    programs.gh.enable = true;
    home.file.".config/gh/hosts.yml".text = ''
      github.com:
        git_protocol: https
        users:
          ColeTrammer
        user: ColeTrammer
    '';
  };
}
