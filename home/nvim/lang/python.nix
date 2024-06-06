{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        python = ["isort" "black"];
      };
    };
    plugins.lsp.servers.pyright = {
      enable = true;
    };
  };
  home.packages = with pkgs; [
    isort
    black
  ];
}
