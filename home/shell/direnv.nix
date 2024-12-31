{ config, lib, ... }:
{
  options = {
    shell.direnv = {
      enable = lib.mkEnableOption "direnv" // {
        default = config.shell.enable;
      };
      enableCompletionAutoloadingWorkaround =
        lib.mkEnableOption "direnv completion autoloading work-around"
        // {
          default = config.shell.direnv.enable && config.preferences.os == "linux";
        };
    };
  };

  config = lib.mkIf config.shell.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/direnv";
          method = "symlink";
        }
      ];
    };

    # Make sure to do this last.
    programs.zsh.initExtra =
      lib.mkIf config.shell.direnv.enableCompletionAutoloadingWorkaround
      <| lib.mkOrder 2000 ''
        ###
        ### Direnv completion autoloading (see https://github.com/direnv/direnv/issues/443)
        ###
        export FPATH
        export XDG_DATA_DIRS

        _direnv_hook() {
          trap -- ''' SIGINT
          eval "$(${config.programs.direnv.package}/bin/direnv export zsh)"
          compinit
          trap - SIGINT
        }
        typeset -ag precmd_functions
        if (( ! ''${precmd_functions[(I)_direnv_hook]} )); then
          precmd_functions=(_direnv_hook $precmd_functions)
        fi
        typeset -ag chpwd_functions
        if (( ! ''${chpwd_functions[(I)_direnv_hook]} )); then
          chpwd_functions=(_direnv_hook $chpwd_functions)
        fi
      '';
  };
}
