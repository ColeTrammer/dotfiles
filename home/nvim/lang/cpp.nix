{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        c = ["clang-format"];
        cpp = ["clang-format"];
      };
    };
    plugins.clangd-extensions = {
      enable = true;
      extraOptions = {
        # We now have native support for inlay hints
        inlay_hints = {
          inline = false;
        };
        ast = {
          role_icons = {
            type = "";
            declaration = "";
            expression = "";
            specifier = "";
            statement = "";
            "template argument" = "";
          };
          kind_icons = {
            Compound = "";
            Recovery = "";
            TranslationUnit = "";
            PackExpansion = "";
            TemplateTypeParm = "";
            TemplateTemplateParm = "";
            TemplateParamObject = "";
          };
        };
      };
    };
    plugins.cmp.extraOptions.sorting.comparators = [
      "cmp.config.compare.offset"
      "cmp.config.compare.exact"
      "cmp.config.compare.recently_used"
      "require('clangd_extensions.cmp_scores')"
      "cmp.config.compare.kind"
      "cmp.config.compare.sort_text"
      "cmp.config.compare.length"
      "cmp.config.compare.order"
    ];
    plugins.lsp = {
      servers.clangd = {
        enable = true;
        package = null;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--header-insertion=iwyu"
          "--completion-style=detailed"
          "--function-arg-placeholders"
          "--fallback-style=llvm"
        ];
        onAttach.function = ''
          vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header (C/C++)", })
        '';
        extraOptions = {
          init_options = {
            usePlaceholders = true;
            completeUnimported = true;
            clangdFileStatus = true;
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    clang-tools
  ];
}
