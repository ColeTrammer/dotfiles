{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formatOnSave = {};
    };
  };
}
