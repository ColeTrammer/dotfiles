{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
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
