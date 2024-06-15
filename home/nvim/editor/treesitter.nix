{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      indent = true;
    };

    extraFiles = {
      "queries/nix/injections.scm" =
        # scheme
        ''
          ;; extends
          ((apply_expression
            function: (_) @_func
            argument: [
              (string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "lua")))
              (indented_string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "lua")))
            ])
            (#match? @_func "(^|\\.)lua(Raw)?(Expr)?$")
            (#set! injection.combined))

          (binding
            attrpath: (attrpath
              (identifier) @_path)
            expression: [
              (string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "lua")))
              (indented_string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "lua")))
            ]
            (#match? @_path "^extraConfigLua(Pre|Post)?$")
            (#set! injection.combined))

          (binding
            attrpath: (attrpath
              (identifier) @_path)
            expression: [
              (string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "vim")))
              (indented_string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "vim")))
            ]
            (#match? @_path "^extraConfigVim(Pre|Post)?$")
            (#set! injection.combined))
        '';
    };
  };
}
