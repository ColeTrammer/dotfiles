{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    preferences = {
      workspacePath = lib.mkOption {
        type = lib.types.path;
        default = "${config.home.homeDirectory}/Workspace";
        description = ''Path to coding workspace.'';
      };

      dotfilesPath = lib.mkOption {
        type = lib.types.path;
        default = "${config.preferences.workspacePath}/nix/dotfiles";
        description = ''Path to dotfiles source.'';
      };

      pager = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.bat}/bin/bat -p --paging=always";
        description = ''Default terminal pager'';
      };

      shell = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.zsh}/bin/zsh";
        description = ''Default shell'';
      };

      terminal = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.alacritty}/bin/alacritty";
        description = ''Default terminal'';
      };

      editor = lib.mkOption {
        type = lib.types.str;
        default = "${config.programs.neovim.package}/bin/nvim";
        description = ''Default editor'';
      };

      font = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.fira-code-nerdfont;
          description = ''Default font package'';
        };

        name = lib.mkOption {
          type = lib.types.str;
          default = "FiraCode Nerd Font";
          description = ''Default font name'';
        };

        size = lib.mkOption {
          type = lib.types.float;
          default = 12.0;
          description = ''Default font size'';
        };
      };
    };
  };

  config = {
    home.sessionVariables = {
      EDITOR = lib.mkForce config.preferences.editor;
      PAGER = config.preferences.pager;
    };

    home.packages = [
      config.preferences.font.package
    ];
  };
}