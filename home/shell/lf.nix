{
  config,
  inputs,
  lib,
  ...
}:
{
  options = {
    shell.lf.enable = lib.mkEnableOption "lf";
  };

  config = lib.mkIf config.shell.lf.enable {
    programs.lf = {
      enable = true;

      settings = {
        preview = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      commands = {
        mkdir = ''%mkdir -p "$@"'';
        mkdir-select = ''
          %{{
            IFS=" "
            mkdir -p -- "$*"
            lf -remote "send $id select \"$*\""
          }}
        '';

        touch = ''
          %{{
            IFS=" "
            for f in "$*"; do
              mkdir -p `dirname "$f"`
              touch "$f"
            done
          %}}
        '';

        touch-edit = ''
          %{{
            IFS=" "
            for f in "$*"; do
              mkdir -p `dirname "$f"`
              touch "$f"
            done
            lf -remote "send $id \$$EDITOR \"$*\""
          %}}
        '';

        touch-edit-exec = ''
          %{{
            IFS=" "
            for f in "$*"; do
              mkdir -p `dirname "$f"`
              touch "$f"
            done
            chmod +x -- "$*"
            lf -remote "send $id \$$EDITOR \"$*\""
          %}}
        '';

        open = ''
          %{{
            case $(file --mime-type -Lb $f) in
              text/* | application/json) lf -remote "send $id \$$EDITOR \$fx";;
              *) for f in $fx; do $OPENER $f > /dev/null 2> /dev/null & done;;
            esac
          %}}
        '';
      };

      keybindings = {
        gh = "cd ~";
        gr = "cd /";
        gw = "cd ${config.preferences.workspacePath}";

        "." = "set hidden!";

        a = "push :mkdir<space>";
        A = "push :mkdir-select<space>";
        D = "delete";
        x = "chmod +x";
        X = "push :touch-edit-exec<space>";
        o = "push :touch<space>";
        O = "push :touch-edit<space>";
      };

      previewer.source = config.preferences.previewer;
    };

    xdg.configFile."lf/icons".source = "${inputs.lf}/etc/icons.example";
    xdg.configFile."lf/colors".source = "${inputs.lf}/etc/colors.example";

    programs.zsh.initExtra = ''
      source ${inputs.lf}/etc/lfcd.sh

      bindkey -s '^F' '^U lfcd\n'
    '';

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/lf";
          method = "symlink";
        }
      ];
    };
  };
}
