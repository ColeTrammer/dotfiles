{
  config,
  nixosConfig,
  pkgs,
  ...
}:
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
        nixd = {
          enable = true;
          package = null;
          settings = {
            nixpkgs = {
              expr = "import <nixpkgs> { }";
            };
            formatting = {
              command = [ "nixfmt" ];
            };
            options = {
              nixos = {
                expr = "(builtins.getFlake \"${config.preferences.dotfilesPath}\").nixosConfigurations.${nixosConfig.networking.hostName}.options";
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
    nixd
    nixfmt-rfc-style
  ];
}
