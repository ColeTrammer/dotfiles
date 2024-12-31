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
      extraInitScripts = lib.mkOption {
        type = with lib.types; listOf path;
        default = [ ];
        description = "Extra zsh files to load";
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
        # Ensure FZF keybindings work with zsh vi mode
        ZVM_INIT_MODE=sourcing
      '';
      initExtra =
        let
          files = [ ./zsh-settings.zsh ] ++ config.shell.zsh.extraInitScripts;
        in
        files |> map (f: "source ${f}") |> lib.strings.concatLines;
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
