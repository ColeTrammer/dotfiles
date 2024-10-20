{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        python = [
          "isort"
          "black"
        ];
      };
    };
    plugins.lsp.servers.pyright = {
      enable = true;
    };
  };

  nvim.otter.allLangs = [ "python" ];

  home.packages = with pkgs; [
    isort
    black
  ];
}
