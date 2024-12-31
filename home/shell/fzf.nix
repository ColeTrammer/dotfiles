{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.fzf.enable = lib.mkEnableOption "fzf" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.fzf.enable (
    let
      fd = "${pkgs.fd}/bin/fd";
      fzf-custom =
        # sh
        ''
          export FZF_DEFAULT_OPTS="\
            --bind ctrl-q:select-all+accept \
            --bind ctrl-u:half-page-up \
            --bind ctrl-d:half-page-down \
            --bind ctrl-x:jump \
            --bind ctrl-f:preview-page-down \
            --bind ctrl-b:preview-page-up \
            --bind ctrl-/:toggle-preview \
            $FZF_DEFAULT_OPTS"

          _fzf_compgen_path() {
            ${fd} --hidden --exclude .git . "$1"
          }

          _fzf_compgen_dir() {
            ${fd} --type=d --hidden --exclude .git . "$1"
          }

          _fzf_comprun() {
            local command=$1
            shift

            case "$command" in
              export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
              unalias|kill) fzf "$@" ;;
              ssh|telnet)   fzf --preview '${pkgs.dig}/bin/dig {}' "$@" ;;
              *)            fzf --preview '${config.preferences.previewer} {}' "$@" ;;
            esac
          }
        '';
    in
    {
      programs.fzf = {
        enable = true;
        defaultCommand = "${fd} --hidden --strip-cwd-prefix --exclude .git";
        changeDirWidgetCommand = "${fd} --type=d --hidden --strip-cwd-prefix --exclude .git";
        changeDirWidgetOptions = [ "--preview '${config.preferences.previewer} {}'" ];
        fileWidgetCommand = "${fd} --hidden --strip-cwd-prefix --exclude .git";
        fileWidgetOptions = [ "--preview '${config.preferences.previewer} {}'" ];
        historyWidgetOptions = [
          "--preview '${config.preferences.pager} -lsh <<<\\\${2..} || echo -n \\\${2..}'"
          "--preview-window wrap"
        ];
      };

      programs.bash.initExtra = lib.mkOrder 1 (
        ''
          source ${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.sh
        ''
        + fzf-custom
      );
      programs.zsh.initExtraFirst = lib.mkOrder 1 (
        ''
          source ${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.sh
        ''
        + fzf-custom
      );
    }
  );
}
