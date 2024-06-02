{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      harpoon2
    ];
    extraConfigLua = ''
      local harpoon = require("harpoon")
      harpoon:setup()
    '';

    keymaps = [
      {
        key = "<leader>k";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require('harpoon')
            harpoon:list():add()
          end
        '';
        options = {desc = "Harpoon File";};
      }
      {
        key = "<leader>l";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end
        '';
        options = {desc = "Harpoon Menu";};
      }
      {
        key = "<leader>ja";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():select(1)
          end
        '';
        options = {desc = "Harpoon Open File 1";};
      }
      {
        key = "<leader>js";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():select(2)
          end
        '';
        options = {desc = "Harpoon Open File 2";};
      }
      {
        key = "<leader>jd";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():select(3)
          end
        '';
        options = {desc = "Harpoon Open File 3";};
      }
      {
        key = "<leader>jf";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():select(4)
          end
        '';
        options = {desc = "Harpoon Open File 4";};
      }
      {
        key = "<leader>jj";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():next()
          end
        '';
        options = {desc = "Harpoon Open Next";};
      }
      {
        key = "<leader>jk";
        mode = "n";
        action.__raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon:list():prev()
          end
        '';
        options = {desc = "Harpoon Open Prev";};
      }
    ];
    plugins.which-key.registrations."<leader>j".name = "+harpoon";
  };
}
