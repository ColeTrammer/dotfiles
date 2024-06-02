{
  imports = [
    ./baseline.nix
    ./edit.nix
  ];

  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = "\\";

    # keymaps for my customer terminal codes
    keymaps = [
      {
        mode = ["i" "s"];
        key = "<C-^>";
        action = "<C-m>";
        options = {
          desc = "Treat ctrl+enter as regular enter";
        };
      }
      {
        mode = ["i" "s"];
        key = "<C-]>";
        action = "<C-m>";
        options = {
          desc = "Treat shift+enter as regular enter";
        };
      }
    ];
  };
}
