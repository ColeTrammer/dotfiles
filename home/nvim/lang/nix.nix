{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
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
        nil_ls = {
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
