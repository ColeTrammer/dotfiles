{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        lua = [ "stylua" ];
      };
    };
    plugins.lint.lintersByFt = {
      lua = [ "luacheck" ];
    };
    plugins.lsp = {
      servers = {
        lua-ls = {
          enable = true;
          package = null;
          extraOptions = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false;
                };
                codeLens = {
                  enable = true;
                };
                completion = {
                  callSnippet = "Replace";
                };
                doc = {
                  privateName = [ "^_" ];
                };
                hint = {
                  enable = true;
                  setType = false;
                  paramType = true;
                  paramName = "Disable";
                  semicolon = "Disable";
                  arrayIndex = "Disable";
                };
              };
            };
          };
        };
      };
    };

    # Lazydev for lua LSP configuration that resolves Neovim plugins.
    extraPlugins = with pkgs.vimPlugins; [ lazydev-nvim ];
    extraConfigLua = ''
      require("lazydev").setup()
    '';
    plugins.cmp.settings.sources = [
      {
        name = "lazydev";
        group_index = 0;
      }
    ];
  };

  nvim.otter.allLangs = [ "lua" ];

  home.packages = with pkgs; [
    stylua
    luajitPackages.luacheck
    lua-language-server
  ];
}
