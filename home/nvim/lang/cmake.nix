{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        cmake = [ "cmake_format" ];
      };
    };
    plugins.lsp.servers.cmake = {
      enable = true;
    };
  };
  nvim.otter.allLangs = [ "cmake" ];

  home.packages = with pkgs; [ cmake-format ];
}
