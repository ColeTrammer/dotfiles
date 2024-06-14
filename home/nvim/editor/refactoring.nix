{
  programs.nixvim = {
    plugins.refactoring = {
      enable = true;
    };
    keymaps = [
      {
        mode = "v";
        key = "<leader>rs";
        action.__raw = ''
          function()
            require("telescope").extensions.refactoring.refactors()
          end'';
        options.desc = "Refactor";
      }
      {
        mode = ["n" "v"];
        key = "<leader>ri";
        action.__raw = ''
          function()
            require("refactoring").refactor("Inline Variable")
          end'';
        options.desc = "Inline Variable";
      }
      {
        mode = "n";
        key = "<leader>rb";
        action.__raw = ''
          function()
            require("refactoring").refactor("Extract Block")
          end'';
        options.desc = "Extract Block";
      }
      {
        mode = "n";
        key = "<leader>rf";
        action.__raw = ''
          function()
            require("refactoring").refactor("Extract Block To File")
          end'';
        options.desc = "Extract Block To File";
      }
      {
        mode = "n";
        key = "<leader>rP";
        action.__raw = ''
          function()
            require("refactoring").debug.printf({ below = false })
          end'';
        options.desc = "Debug Print";
      }
      {
        mode = "n";
        key = "<leader>rp";
        action.__raw = ''
          function()
            require("refactoring").debug.print_var({ normal = true })
          end'';
        options.desc = "Debug Print Variable";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action.__raw = ''
          function()
            require("refactoring").debug.cleanup({})
          end'';
        options.desc = "Debug Cleanup";
      }
      {
        mode = "v";
        key = "<leader>rf";
        action.__raw = ''
          function()
            require("refactoring").refactor("Extract Function")
          end'';
        options.desc = "Extract Function";
      }
      {
        mode = "v";
        key = "<leader>rF";
        action.__raw = ''
          function()
            require("refactoring").refactor("Extract Function To File")
          end'';
        options.desc = "Extract Function To File";
      }
      {
        mode = "v";
        key = "<leader>rx";
        action.__raw = ''
          function()
            require("refactoring").refactor("Extract Variable")
          end'';
        options.desc = "Extract Variable";
      }
      {
        mode = "v";
        key = "<leader>rp";
        action.__raw = ''
          function()
            require("refactoring").debug.print_var()
          end'';
        options.desc = "Debug Print Variable";
      }
    ];
    plugins.which-key.registrations."<leader>r".name = "+refactor";
  };
}
