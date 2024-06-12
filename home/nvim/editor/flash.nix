{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
    };
    plugins.telescope = let
      telescopeFlash = ''
        function(prompt_bufnr)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                end,
              },
            },
            action = function(match)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              picker:set_selection(match.pos[1] - 1)
            end,
          })
        end
      '';
    in {
      settings.defaults.mappings = {
        i."<c-s>".__raw = telescopeFlash;
        n.s.__raw = telescopeFlash;
      };
    };
    keymaps = [
      {
        key = "s";
        mode = ["n" "x" "o"];
        action.__raw = ''function() require("flash").jump() end'';
        options.desc = "Flash";
      }
      {
        key = "S";
        mode = ["n" "o" "x"];
        action.__raw = ''function() require("flash").treesitter() end'';
        options.desc = "Flash Treesitter";
      }
      {
        key = "r";
        mode = "o";
        action.__raw = ''function() require("flash").remote() end'';
        options.desc = "Remote Flash";
      }
      {
        key = "R";
        mode = ["o" "x"];
        action.__raw = ''function() require("flash").treesitter_search() end'';
        options.desc = "Treesitter Search";
      }
      {
        key = "<c-s>";
        mode = "c";
        action.__raw = ''function() require("flash").toggle() end'';
        options.desc = "Toggle Flash Search";
      }
    ];
  };
}
