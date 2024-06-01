{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls = {
          enable = true;
          extraOptions = {
            settings = {
              nil = {
                formatting = {command = ["alejandra"];};
                nix = {
                  maxMemoryMB = 16 * 1024;
                  flake = {
                    autoArchive = true;
                    autoEvalInputs = true;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
