{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        sh = [ "shfmt" ];
      };
    };
    plugins.lint.lintersByFt = {
      # NOTE: no need to setup the linter since bashls does so automatically.
      # sh = ["shellcheck"];
      zsh = [ "zsh" ];
    };
    plugins.lsp.servers.bashls = {
      enable = true;
    };
  };

  nvim.otter.allLangs = [ "sh" ];

  home.packages = with pkgs; [
    shellcheck
    shfmt
  ];
}
