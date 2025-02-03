{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        zig = [
          "zigfmt"
        ];
      };
    };
    plugins.lsp = {
      servers.zls = {
        enable = true;
        package = null;
      };
    };
    plugins.neotest.adapters.zig.enable = true;
  };

  home.packages = with pkgs; [
    zig
    zls
  ];
}
