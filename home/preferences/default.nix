{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./themes/catppuccin.nix
    ./themes/tokyonight.nix
  ];

  options = {
    preferences = {
      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin";
        description = ''Default theme'';
      };

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
        default = "${pkgs.bat}/bin/bat --paging=always --color=always -p";
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

      previewer = lib.mkOption {
        type = lib.types.path;
        default = "${pkgs.pistol}/bin/pistol";
        description = ''Default terminal previewer'';
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

    preferences.themes.${config.preferences.theme} = {
      enable = true;
      default = true;
    };
  };
}
