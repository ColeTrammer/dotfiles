{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "autoformatting";
        src = ./.;
      })
    ];
    extraConfigLua = ''
      require("autoformatting").setup()
    '';
    keymaps = [
      {
        key = "<leader>uff";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_file()
          end
        '';
        options.desc = "Formatting Toggle (File)";
      }
      {
        key = "<leader>uft";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_filetype()
          end
        '';
        options.desc = "Formatting Toggle (File Type)";
      }
      {
        key = "<leader>ufg";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_globally()
          end
        '';
        options.desc = "Formatting Toggle (Global)";
      }
      {
        key = "<leader>ufr";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").reset()
          end
        '';
        options.desc = "Formatting Toggle (Reset)";
      }
      {
        key = "<leader>ufs";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").display_status()
          end
        '';
        options.desc = "Formatting Status";
      }
      {
        key = "<leader>ufo";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").formatter_override()
          end
        '';
        options.desc = "Formatter Override";
      }
    ];
    plugins.which-key.registrations."<leader>uf".group = "+autoformatting";
  };
  nvim.auto-session =
    let
      getCwd = helpers.lua ''
        local function get_cwd_as_name()
          local dir = vim.fn.getcwd(0)
          return dir:gsub("[^A-Za-z0-9]", "_")
        end
      '';
    in
    {
      preSaveCmds = [
        (helpers.luaRawExpr ''
          return function()
            ${getCwd}

            local autoformatting = require("autoformatting")
            autoformatting.write_data(get_cwd_as_name())
          end
        '')
      ];
      postRestoreCmds = [
        (helpers.luaRawExpr ''
          return function()
            ${getCwd}

            local autoformatting = require("autoformatting")
            autoformatting.read_data(get_cwd_as_name())
          end
        '')
      ];
    };
}
