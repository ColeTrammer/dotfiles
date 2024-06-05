{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        sh = ["shfmt"];
      };
    };
    plugins.lint.lintersByFt = {
      # NOTE: no need to setup the linter since bashls does so automatically.
      # sh = ["shellcheck"];
      zsh = ["zsh"];
    };
    plugins.lsp.servers.bashls = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    shellcheck
    shfmt
  ];
}
