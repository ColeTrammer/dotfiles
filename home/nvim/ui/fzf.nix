{
  config,
  helpers,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      package = pkgs.vimPlugins.fzf-lua.overrideAttrs {
        src = inputs.fzf-lua;
        version = "git";
      };
      lazyLoad.settings = {
        cmd = [
          "FzfLua"
          "FZF"
        ];
        keys =
          let
            h = key: action: desc: {
              key = key;
              action = "<cmd>FzfLua ${action}<cr>";
              options.desc = desc;
            };
            hv = key: action: desc: {
              key = key;
              action = "<cmd>FzfLua ${action}<cr>";
              options.desc = desc;
              mode = "v";
            };
          in
          helpers.lazyKeyMaps [
            (h "<leader><space>" "files" "Find Files")
            (h "<leader>/" "live_grep" "Search Files")
            (h "<leader>:" "command_history" "Command History")
            (h "<leader>," "buffers sort_mru=true sort_lastused=true" "Switch Buffer")
            (h "<leader>bb" "buffers sort_mru=true sort_lastused=true" "Switch Buffer")
            (h "<leader>s\"" "regsiers" "Registers")
            (h "<leader>sa" "autocmds" "Auto Commands")
            (h "<leader>sb" "grep_curbuf" "Buffer")
            (h "<leader>sc" "commands" "Commands")
            (h "<leader>sd" "diagnostics_document" "Diagnostics (Buffer)")
            (h "<leader>sD" "diagnostics_workspace" "Diagnostics (All)")
            (h "<leader>sf" "git_files" "Find Git Files")
            (h "<leader>sF" "find_files" "Find Hidden Files")
            (h "<leader>sg" "live_grep" "Grep")
            (h "<leader>sh" "helptags" "Help Pages")
            (h "<leader>sH" "highlights" "Highlight Groups")
            (h "<leader>sj" "jumps" "Jumplist")
            (h "<leader>sk" "keymaps" "Key Maps")
            (h "<leader>sl" "loclist" "Location List")
            (h "<leader>sL" "lsp_finder" "LSP Finder")
            (h "<leader>sM" "manpages" "Man Pages")
            (h "<leader>sm" "marks" "Marks")
            (h "<leader>sq" "quickfix" "Quickfix List")
            (h "<leader>sR" "oldfiles" "Recent Files")
            (h "<leader>sz" "resume" "FzfLua Resume")
            (h "<leader>ss" "lsp_document_symbols" "Symbols (Buffer)")
            (h "<leader>sS" "lsp_live_workspace_symbols" "Symbols (All)")
            (h "<leader>st" "treesitter" "Treesitter")
            (h "<leader>sw" "grep_cword" "Search current word")
            (hv "<leader>sw" "grep_visual" "Search current selection")
          ];
      };
      settings = {
        fzf_opts = {
          "--no-scrollbar" = true;
        };
        defaults = {
          file_icons = "mini";
          keymap = {
            fzf = {
              "ctrl-q" = "select-all+accept";
              "ctrl-u" = "half-page-up";
              "ctrl-d" = "half-page-down";
              "ctrl-x" = "jump";
              "ctrl-f" = "preview-page-down";
              "ctrl-b" = "preview-page-up";
            };
            builtin = {
              "<c-f>" = "preview-page-down";
              "<c-b>" = "preview-page-up";
            };
          };
        };
        previewers = {
          builtin = {
            extensions =
              let
                image_preview = [
                  "chafa"
                  "{file}"
                  "--format=symbols"
                ];
              in
              {
                png = image_preview;
                jpg = image_preview;
                jpeg = image_preview;
                gif = image_preview;
                webp = image_preview;
                svg = image_preview;
              };
          };
        };
        winopts = {
          width = 0.8;
          height = 0.8;
          row = 0.5;
          col = 0.5;
          backdrop = 70;
          preview = {
            scrollchars = [
              "┃"
              ""
            ];
          };
          on_create = helpers.luaRawExpr ''
            return function()
              -- Prevent using tmux navigator bindings while in fzf.
              vim.keymap.set("t", "<c-j>", "<c-j>", { nowait = true, buffer = true })
              vim.keymap.set("t", "<c-k>", "<c-k>", { nowait = true, buffer = true })
              vim.keymap.set("t", "<c-l>", "<c-l>", { nowait = true, buffer = true })
              vim.keymap.set("t", "<c-h>", "<c-h>", { nowait = true, buffer = true })
            end
          '';
        };
        files = {
          cwd_prompt = false;
          actions = {
            "ctrl-h" = [
              (helpers.luaRaw ''require("fzf-lua.actions").toggle_hidden'')
            ];
          };
        };
        grep = {
          actions = {
            "ctrl-h" = [
              (helpers.luaRaw ''require("fzf-lua.actions").toggle_hidden'')
            ];
          };
        };
        lsp = {
          symbols = {
            # Color code based on LSP kind.
            symbol_hl = helpers.luaRawExpr ''
              return function(s)
                return "BlinkCmpKind" .. s
              end
            '';
            # Remove [] from symbol icon and type.
            symbol_fmt = helpers.luaRawExpr ''
              return function(s)
                return s:lower() .. "\t"
              end
            '';
          };
          code_actions.previewer = lib.mkIf config.shell.delta.enable "codeaction_native";
        };
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>s";
        group = "+search";
      }
    ];
  };

  home.packages = with pkgs; [
    chafa
  ];
}
