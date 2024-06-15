{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        just = [
          "just"
          "injected"
        ];
      };
    };
  };

  home.packages = with pkgs; [ just ];
}
