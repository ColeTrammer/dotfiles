{
  helpers,
  inputs,
  pkgs,
  ...
}:
let
  multicursor-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "multicursor-nvim";
    src = inputs.multicursor-nvim;
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      multicursor-nvim
    ];
    plugins.lz-n.plugins = [
      {
        __unkeyed-1 = "multicursor-nvim";
        keys = helpers.lazyKeyMaps [
          {
            key = "<leader>mk";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineAddCursor(-1)
              end
            '';
            options.desc = "Add Cursor Above";
          }
          {
            key = "<C-S-k>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineAddCursor(-1)
              end
            '';
            options.desc = "Add Cursor Above";
          }
          {
            key = "<leader>mj";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineAddCursor(1)
              end
            '';
            options.desc = "Add Cursor Below";
          }
          {
            key = "<C-S-j>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineAddCursor(1)
              end
            '';
            options.desc = "Add Cursor Below";
          }
          {
            key = "<leader>mK";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineSkipCursor(-1)
              end
            '';
            options.desc = "Skip Cursor Above";
          }
          {
            key = "<C-S-A-k>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineSkipCursor(-1)
              end
            '';
            options.desc = "Skip Cursor Above";
          }
          {
            key = "<leader>mJ";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineSkipCursor(1)
              end
            '';
            options.desc = "Skip Cursor Below";
          }
          {
            key = "<C-S-A-j>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").lineSkipCursor(1)
              end
            '';
            options.desc = "Skip Cursor Below";
          }
          {
            key = "<leader>mn";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").matchAddCursor(1)
              end
            '';
            options.desc = "Match Add Cursor Forward";
          }
          {
            key = "<leader>ms";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").matchSkipCursor(1)
              end
            '';
            options.desc = "Match Skip Cursor Forward";
          }
          {
            key = "<leader>mN";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").matchAddCursor(-1)
              end
            '';
            options.desc = "Match Add Cursor Backward";
          }
          {
            key = "<leader>mS";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").matchSkipCursor(-1)
              end
            '';
            options.desc = "Match Skip Cursor Backward";
          }
          {
            key = "<leader>mA";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").matchAllAddCursors
            '';
            options.desc = "Match Add All Cursors";
          }
          {
            key = "<leader>mh";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").prevCursor
            '';
            options.desc = "Prev Cursor";
          }
          {
            key = "<C-S-h>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").prevCursor
            '';
            options.desc = "Prev Cursor";
          }
          {
            key = "<leader>ml";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").nextCursor
            '';
            options.desc = "Next Cursor";
          }
          {
            key = "<C-S-l>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").nextCursor
            '';
            options.desc = "Next Cursor";
          }
          {
            key = "<leader>mx";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").deleteCursor
            '';
            options.desc = "Delete Cursor";
          }
          {
            key = "<C-leftmouse>";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").handleMouse
            '';
            options.desc = "Toggle Cursor (Mouse)";
          }
          {
            key = "<leader>mq";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").toogleCursor
            '';
            options.desc = "Cursor Mode";
          }
          {
            key = "<leader>mQ";
            mode = [
              "n"
              "v"
            ];
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").duplicateCursors
            '';
            options.desc = "Duplicate Cursors";
          }
          {
            key = "<leader>mv";
            mode = "n";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").restoreCursors
            '';
            options.desc = "Restore Cursors";
          }
          {
            key = "<leader>ma";
            mode = "n";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").alignCursors
            '';
            options.desc = "Align Cursors";
          }
          {
            key = "<leader>mm";
            mode = "v";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").splitCursors
            '';
            options.desc = "Split Cursors";
          }
          {
            key = "I";
            mode = "v";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").insertVisual
            '';
            options.desc = "Insert Visual";
          }
          {
            key = "A";
            mode = "v";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").appendVisual
            '';
            options.desc = "Append Visual";
          }
          {
            key = "M";
            mode = "v";
            action = helpers.luaRawExpr ''
              return require("multicursor-nvim").matchCursors
            '';
            options.desc = "Match Cursors";
          }
          {
            key = "<leader>mt";
            mode = "v";
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").transposeCursors(1)
              end
            '';
            options.desc = "Transpose Cursors Forward";
          }
          {
            key = "<leader>mT";
            mode = "v";
            action = helpers.luaRawExpr ''
              return function()
                require("multicursor-nvim").transposeCursors(-1)
              end
            '';
            options.desc = "Transpose Cursors Backward";
          }
        ];
        after = helpers.luaRawExpr ''
          return function()
            local mc = require("multicursor-nvim")
            local set = vim.keymap.set
            mc.setup()

            -- Esc
            set("n", "<esc>", function()
              if mc.hasCursors() then
                mc.clearCursors()
              else
                -- Default <esc> handler.
                vim.cmd("noh")
              end
            end)

            -- Jumplist support
            set({ "v", "n" }, "<c-i>", mc.jumpForward)
            set({ "v", "n" }, "<c-o>", mc.jumpBackward)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
          end
        '';
      }
    ];
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>m";
        group = "+multicursor";
      }
    ];
  };
}
