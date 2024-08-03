{
  programs.nixvim = {
    plugins.telescope =
      let
        find_files_with_hidden = ''
          function()
            require('telescope.builtin').find_files({ hidden = true })
          end
        '';
      in
      {
        enable = true;
        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
            mappings = {
              i = {
                "<A-h>".__raw = find_files_with_hidden;
                "<A-.>".__raw = find_files_with_hidden;
              };
              n = {
                q.__raw = "require('telescope.actions').close";
                "g.".__raw = find_files_with_hidden;
              };
            };
          };
        };
        extensions = {
          fzf-native = {
            enable = true;
          };
          undo = {
            enable = true;
          };
        };
        keymaps = {
          "<leader><space>" = {
            action = "find_files find_command=rg,--ignore,--hidden,--files,--glob,!**/.git/*";
            options.desc = "Find Files";
          };
          "<leader>/" = {
            action = "live_grep";
            options.desc = "Search Files";
          };
          "<leader>:" = {
            action = "command_history";
            options.desc = "Command History";
          };
          "<leader>," = {
            action = "buffers sort_mru=true sort_lastused=true";
            options.desc = "Switch Buffer";
          };
          "<leader>bb" = {
            action = "buffers sort_mru=true sort_lastused=true";
            options.desc = "Switch Buffer";
          };
          "<leader>s\"" = {
            action = "registers";
            options.desc = "Registers";
          };
          "<leader>sa" = {
            action = "autocommands";
            options.desc = "Auto Commands";
          };
          "<leader>sb" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "Buffer";
          };
          "<leader>sc" = {
            action = "commands";
            options.desc = "Commands";
          };
          "<leader>sd" = {
            action = "diagnostics bufnr=0";
            options.desc = "Diagnostics (Buffer)";
          };
          "<leader>sD" = {
            action = "diagnostics";
            options.desc = "Diagnostics (All)";
          };
          "<leader>sf" = {
            action = "git_files";
            options.desc = "Find Git Files";
          };
          "<leader>sF" = {
            action = "find_files";
            options.desc = "Find Hidden Files";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "Grep";
          };
          "<leader>sh" = {
            action = "help_pages";
            options.desc = "Help Pages";
          };
          "<leader>sH" = {
            action = "highlights";
            options.desc = "Highlight Groups";
          };
          "<leader>sj" = {
            action = "jumplist";
            options.desc = "Jumplist";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "Key Maps";
          };
          "<leader>sl" = {
            action = "loclist";
            options.desc = "Location List";
          };
          "<leader>sM" = {
            action = "man_pages";
            options.desc = "Man Pages";
          };
          "<leader>sm" = {
            action = "marks";
            options.desc = "Marks";
          };
          "<leader>so" = {
            action = "vim_options";
            options.desc = "Options";
          };
          "<leader>sq" = {
            action = "quickfix";
            options.desc = "Quickfix List";
          };
          "<leader>sR" = {
            action = "oldfiles";
            options.desc = "Recent Files";
          };
          "<leader>sz" = {
            action = "resume";
            options.desc = "Telescope Resume";
          };
          "<leader>ss" = {
            action = "lsp_document_symbols";
            options.desc = "Symbols (Buffer)";
          };
          "<leader>sS" = {
            action = "lsp_dynamic_workspace_symbols";
            options.desc = "Symbols (All)";
          };
          "<leader>st" = {
            action = "treesitter";
            options.desc = "Treesitter";
          };
          "<leader>sT" = {
            action = "pickers";
            options.desc = "Telescope Pickers";
          };
          "<leader>su" = {
            action = "undo";
            options.desc = "Undo History";
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
}
