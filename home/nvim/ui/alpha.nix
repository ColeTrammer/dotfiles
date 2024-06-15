{ config, ... }:
let
  header = text: {
    type = "text";
    opts = {
      hl = "AlphaHeader";
      position = "center";
    };
    val = text;
  };
  padding = val: {
    inherit val;

    type = "padding";
  };
  group = values: {
    type = "group";
    val = values;
    opts.spacing = 1;
  };
  button = label: shortcut: action: {
    type = "button";
    opts = {
      inherit shortcut;

      position = "center";
      width = 50;
      cursor = 3;
      align_shortcut = "right";
      hl = "AlphaButtons";
      hl_shortcut = "AlphaShortcut";
      keymap = [
        "n"
        shortcut
        action
        {
          noremap = true;
          silent = true;
          nowait = true;
        }
      ];
    };
    val = label;
  };
  footer = {
    __raw = ''
      {
        type = "text",
        opts = {
          hl = "AlphaFooter",
          position = "center",
        },
        val = require'alpha.fortune'(),
      }
    '';
  };
in
{
  programs.nixvim = {
    plugins.alpha = {
      enable = true;
      theme = null;
      opts.margin = 5;
      layout = [
        (padding 4)
        (header [
          "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
          "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ])
        (padding 4)
        (group [
          (button " New file" "n" "<cmd> ene <BAR> startinsert <cr>")
          (button " Recent" "r" "<cmd> Telescope oldfiles <cr>")
          (button "󰈞 Find file" "f" "<cmd> Telescope find_files <cr>")
          (button "󰈬 Search files" "s" "<cmd> Telescope live_grep <cr>")
          (button " File Explorer" "-" "<cmd> Oil <cr>")
          (button " Git" "g" "<cmd> Neogit <cr>")
          (button " Config" "c" ":e ${config.preferences.dotfilesPath} <CR>")
          (button " Quit" "q" "<cmd> qa <cr>")
        ])
        (padding 2)
        footer
      ];
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>;";
        action = "<cmd>Alpha<cr>";
        options = {
          desc = "Open Dashboard";
        };
      }
    ];
  };
}
