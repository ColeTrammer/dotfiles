{
  config,
  inputs,
  lib,
  ...
}:
{
  options = {
    shell.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.shell.yazi.enable {
    programs.yazi = {
      enable = true;
      keymap = {
        manager.prepend_keymap = [
          {
            run = "quit --no-cwd-file";
            on = [ "<C-q>" ];
          }
        ];
      };
      settings = {
        manager = {
          linemode = "size";
          show_hidden = true;
          show_symlink = true;
          sort_by = "natural";
          sort_dir_first = true;
          sort_reverse = false;
          sort_sensitive = false;
        };
        preview = {
          cache_dir = "${config.xdg.cacheHome}";
        };
      };
      plugins = {
        full-border = "${inputs.yazi-plugins}/full-border.yazi";
      };
    };

    programs.zsh.initExtra =
      # sh
      ''
        function yy() {
        	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        	yazi "$@" --cwd-file="$tmp"
        	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        		cd -- "$cwd"
        	fi
        	rm -f -- "$tmp"
        }

        bindkey -s '^F' '^U yy\n'
      '';
  };
}
