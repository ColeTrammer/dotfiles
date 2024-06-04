{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        just = ["just"];
      };
    };
  };

  home.packages = with pkgs; [
    just
  ];
}
