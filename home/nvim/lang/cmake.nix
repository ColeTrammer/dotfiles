{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
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
