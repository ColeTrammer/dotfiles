{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.zsh = {
      enable = lib.mkEnableOption "zsh" // {
        default = config.shell.enable;
      };
      enableNixShellPlugin = lib.mkEnableOption "zsh nix shell plugin" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "viins";
      autosuggestion = {
        enable = true;
      };
      history = {
        save = 1000000;
        size = 1000000;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      initExtraFirst = lib.mkOrder 0 ''
        ZVM_INIT_MODE=sourcing
      '';
      initExtra = ''
        # Options
        setopt interactivecomments

        source ~/.config/zsh/zsh-settings.zsh
      '';
      plugins =
        [
          {
            name = "fzf-tab";
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
            src = pkgs.zsh-fzf-tab;
          }
          {
            name = "fast-syntax-highlighting";
            file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
            src = pkgs.zsh-fast-syntax-highlighting;
          }
          {
            name = "vi-mode";
            src = pkgs.zsh-vi-mode;
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
        ]
        ++ (
          if config.shell.zsh.enableNixShellPlugin then
            [
              {
                name = "nix-shell";
                file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
                src = pkgs.zsh-nix-shell;
              }
            ]
          else
            [ ]
        );
    };

    home.file.".config/zsh/zsh-settings.zsh".source = ./zsh-settings.zsh;

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/zsh";
          method = "symlink";
        }
      ];
    };
  };
}
