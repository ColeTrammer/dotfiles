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
  };

  home.packages = with pkgs; [
    stylua
    luajitPackages.luacheck
    lua-language-server
  ];
}
