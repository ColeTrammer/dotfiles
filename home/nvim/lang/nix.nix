{
  config,
  lib,
  nixosConfig ? { },
  pkgs,
  ...
}:
{
  options = {
    nvim.langs.nix.nixos = lib.mkEnableOption "nixd nixos config" // {
      default = lib.attrsets.hasAttrByPath [ "networking" "hostName" ] nixosConfig;
    };
  };

  config = {
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
                nixos = lib.mkIf config.nvim.langs.nix.nixos {
                  expr = "(builtins.getFlake \"${config.preferences.dotfilesPath}\").nixosConfigurations.${
                    lib.attrsets.getAttrFromPath [ "networking" "hostName" ] nixosConfig
                  }.options";
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
  };
}
