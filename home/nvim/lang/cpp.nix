{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    nvim.lang.cpp = {
      cppdbg =
        lib.mkEnableOption "VS Code Cpp Tools Debugger"
        // {
          default = config.preferences.os == "linux";
        };

      queryDriver = lib.mkOption {
        type = with lib.types; listOf str;
        default = [
          "/nix/store/*/bin/clang*"
          "/nix/store/*/bin/gcc*"
          "/nix/store/*/bin/g++*"
        ];
        description = ''
          List of globs to pass to clangd's query driver argument.
        '';
      };
    };
  };

  config = let
    clangVersion = "18";
    clangUnwrapped = pkgs."llvmPackages_${clangVersion}".clang-unwrapped;
    clang = pkgs."llvmPackages_${clangVersion}".libcxxClang;
    clangToolsBase = pkgs."clang-tools_${clangVersion}";

    # This keeps every package other than clangd from the original clang-tools, which is needed
    # since we want to use a custom clangd wrapper.
    clangTools = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "clang-tools-without-clangd";
      version = clangToolsBase.version;
      unpackPhase = "true";
      installPhase = ''
        mkdir -p $out/bin
        cp ${clangToolsBase}/bin/* $out/bin
        rm $out/bin/clangd
      '';
    });

    # We don't want to use the default clangd wrapper because it hard codes a resource root pointing to GCC 13.
    # This causes query-driver to not work correctly, as this path shows up first in the include order, meaning
    # most includes with point to the wrong place.
    #
    # Using the unwrapped clangd directly doesn't work as query-driver explicily ignores the resource root path
    # as it wants to use the path that ships with clang. Therefore, we need to make our own wrapper which provides
    # the correct resource root, but nothing else, since query driver will deduce all other include paths.
    #
    # This probably isn't something which should be upstreamed to nixpkgs since it will break clangd if you don't
    # configure query-driver correctly.
    clangd = pkgs.writeShellScriptBin "clangd" ''
      export CPATH=''${CPATH}''${CPATH:+':'}:${clang}/resource-root/include
      export CPLUS_INCLUDE_PATH=''${CPLUS_INCLUDE_PATH}''${CPLUS_INCLUDE_PATH:+':'}:${clang}/resource-root/include
      exec -a "$0" ${clangUnwrapped}/bin/$(basename $0) "$@"
    '';

    queryDriver = lib.strings.concatMapStrings (x: x + ",") config.nvim.lang.cpp.queryDriver;
  in {
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
      plugins.cmp.settings.sorting.comparators = [
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
            "${clangd}/bin/clangd"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--completion-style=detailed"
            "--function-arg-placeholders"
            "--fallback-style=llvm"
            "--query-driver=${queryDriver}"
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
      plugins.dap.adapters = {
        executables = lib.mkIf config.nvim.lang.cpp.cppdbg {
          cppdbg = {
            command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
            id = "cppdbg";
          };
        };
        servers = {
          lldb = {
            port = "\${port}";
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = ["--port" "\${port}"];
            };
          };
          codelldb = {
            port = "\${port}";
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = ["--port" "\${port}"];
            };
          };
        };
      };
    };

    nvim.dap.vscode-adapters =
      {
        codelldb = ["c" "cpp" "rust"];
      }
      // (
        if config.nvim.lang.cpp.cppdbg
        then {
          cppdbg = ["c" "cpp"];
        }
        else {}
      );

    home.packages = with pkgs; [
      clang
      clangTools
      clangd
      gdb
      lldb
    ];
  };
}
