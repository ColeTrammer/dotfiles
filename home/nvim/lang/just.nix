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

  nvim.otter = {
    langs = [ "just" ];
    allLangs = [ "just" ];
  };

  home.packages = with pkgs; [ just ];
}
