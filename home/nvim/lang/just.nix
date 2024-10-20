{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
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
