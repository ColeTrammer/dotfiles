{pkgs, ...}: {
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
      gw = "cd ~/Workspace";

      "." = "set hidden!";

      a = "push :mkdir<space>";
      A = "push :mkdir-select<space>";
      D = "delete";
      x = "chmod +x";
      X = "push :touch-edit-exec<space>";
      o = "push :touch<space>";
      O = "push :touch-edit<space>";
    };

    previewer.source = "${pkgs.pistol}/bin/pistol";
  };

  xdg.configFile."lf/icons".source = ./lf-icons.txt;
  xdg.configFile."lf/colors".source = ./lf-colors.txt;

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".local/share/lf"
    ];
  };
}
