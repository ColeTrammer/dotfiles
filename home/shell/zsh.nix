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
            src = pkgs.zsh-fzf-tab.overrideAttrs {
              nativeBuildInputs = [ pkgs.autoconf ];
              configurePhase = ''
                runHook preConfigure

                pushd modules

                tar -xf ${pkgs.zsh.src}
                ln -s $(pwd)/Src/fzftab.c zsh-${pkgs.zsh.version}/Src/Modules/
                ln -s $(pwd)/Src/fzftab.mdd zsh-${pkgs.zsh.version}/Src/Modules/

                pushd zsh-${pkgs.zsh.version}

                # Apply patches from zsh
                ${lib.concatStringsSep "\n" (map (patch: "patch -p1 -i ${patch}") pkgs.zsh.patches)}

                if [[ ! -f ./configure ]]; then
                  ./Util/preconfig
                fi
                if [[ ! -f ./Makefile ]]; then
                  ./configure --disable-gdbm --without-tcsetpgrp
                fi

                popd
                popd

                runHook postConfigure
              '';
            };
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
