{ pkgs, ... }:
{
  programs.nixvim = {
    # This plugin is a dependency of several other plugins, such as noice.
    extraPlugins = with pkgs.vimPlugins; [ nui-nvim ];
  };
}
