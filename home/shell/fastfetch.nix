{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.fastfetch = {
      enable = lib.mkEnableOption "fastfetch" // {
        default = config.shell.enable;
      };

      extraNetworkInfo = lib.mkEnableOption "fastfetch confidential network info" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.shell.fastfetch.enable {
    home.packages = with pkgs; [ fastfetch ];

    xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON (
      let
        escape = builtins.fromJSON ''"\u001b"'';
        os = config.preferences.os;
        osIcon = if os == "linux" then " " else " ";
      in
      {
        logo = {
          padding = {
            top = 1;
          };
        };
        display = {
          separator = "  ";
        };
        modules =
          [
            {
              type = "custom";
              format = "${escape}[90m┌──────────────────────────────────────────────────────────────┐";
            }
            {
              type = "os";
              key = "${osIcon}OS";
              keyColor = "yellow";
            }
            {
              type = "kernel";
              key = "│ ├";
              format = "{1} {2}";
              keyColor = "yellow";
            }
            {
              type = "packages";
              key = "│ ├󰏖";
              keyColor = "yellow";
            }
            {
              type = "shell";
              key = "│ └";
              keyColor = "yellow";
            }
            {
              type = "wm";
              key = " DE";
              keyColor = "blue";
            }
            {
              type = "lm";
              key = "│ ├󰧨";
              keyColor = "blue";
            }
            {
              type = "theme";
              key = "│ ├󰉼";
              keyColor = "blue";
            }
            {
              type = "icons";
              key = "│ ├󰀻";
              keyColor = "blue";
            }
            {
              type = "cursor";
              key = "│ ├󰇀";
              keyColor = "blue";
            }
            {
              type = "terminal";
              key = "│ ├";
              keyColor = "blue";
            }
            {
              type = "wallpaper";
              key = "│ └󰸉";
              keyColor = "blue";
            }
            {
              type = "host";
              key = "󰌢 PC";
              keyColor = "green";
            }
            {
              type = "cpu";
              key = "│ ├󰻠";
              keyColor = "green";
            }
            {
              type = "gpu";
              key = "│ ├󰍛";
              keyColor = "green";
            }
            {
              type = "disk";
              key = "│ ├";
              keyColor = "green";
            }
            {
              type = "memory";
              key = "│ ├󰑭";
              keyColor = "green";
            }
            {
              type = "swap";
              key = "│ ├󰓡";
              keyColor = "green";
            }
            {
              type = "display";
              key = "│ ├󰍹";
              keyColor = "green";
            }
            {
              type = "uptime";
              key = "│ └󰅐";
              keyColor = "green";
            }
            {
              type = "title";
              key = "󰀂 IN";
              format = "{2}";
              keyColor = "cyan";
            }
          ]
          ++ (
            if config.shell.fastfetch.extraNetworkInfo then
              [
                {
                  type = "wifi";
                  key = "│ ├";
                  format = "{4}";
                  keyColor = "cyan";
                }
                {
                  type = "publicip";
                  key = "│ ├󰩠";
                  keyColor = "cyan";
                }
              ]
            else
              [ ]
          )
          ++ [
            {
              type = "localip";
              key = "│ └󰩟";
              compact = true;
              keyColor = "cyan";
            }
            {
              type = "custom";
              format = "${escape}[90m└──────────────────────────────────────────────────────────────┘";
            }
            "break"
            {
              type = "colors";
              symbol = "circle";
              paddingLeft = 24;
            }
            "break"
          ];
      }
    );

    programs.zsh.initExtra = ''
      bindkey -s '^X' '^U fastfetch\n'
    '';
  };
}
