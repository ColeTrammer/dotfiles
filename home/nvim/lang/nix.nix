{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        nix = [
          "nixfmt"
          "injected"
        ];
      };
    };
    plugins.lint.lintersByFt = {
      nix = [ "nix" ];
    };
    plugins.lsp = {
      servers = {
        nil-ls = {
          enable = true;
          package = null;
          extraOptions = {
            settings = {
              nil = {
                formatting = {
                  command = [ "nixfmt" ];
                };
                nix = {
                  maxMemoryMB = 4 * 1024;
                  flake = {
                    autoArchive = true;
                    autoEvalInputs = true;
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  nvim.otter = {
    langs = [ "nix" ];
    allLangs = [ "nix" ];
  };

  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];
}
