{
  programs.nixvim = {
    plugins.illuminate = {
      enable = true;
      delay = 200;
      largeFileCutoff = 10000;
      largeFileOverrides = {
        providers = [ "lsp" ];
      };
    };
  };
}
