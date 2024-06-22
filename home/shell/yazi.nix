{
  config,
  helpers,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.shell.yazi.enable (
    let
      map = builtins.map;
      mapAttrs = lib.mapAttrs;
      getAttrs = lib.getAttrs;
      mkMerge = lib.mkMerge;
      foldAttrs = lib.foldAttrs;

      plugins = [
        {
          name = "full-border";
          path = "${inputs.yazi-plugins}/full-border.yazi";
        }
      ];
      pluginsPath =
        { name, path, ... }:
        {
          xdg.configFile."yazi/plugins/${name}.yazi".source = path;
        };
      pluginInit = { name, ... }: helpers.lua ''require("${name}"):setup()'';

      pluginOptions = map pluginsPath plugins;
      pluginInits = map pluginInit plugins;

      mkMergeTopLevel =
        names: attrs: getAttrs names (mapAttrs (k: v: mkMerge v) (foldAttrs (n: a: [ n ] ++ a) [ ] attrs));
    in
    mkMergeTopLevel
      [
        "programs"
        "xdg"
      ]
      (
        [
          {
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
              initLua = pkgs.writeText "init.lua" pluginInits;
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
          }
        ]
        ++ pluginOptions
      )
  );
}
