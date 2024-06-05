{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        nix = ["alejandra"];
      };
    };
    plugins.lint.lintersByFt = {
      nix = ["nix"];
    };
    plugins.lsp = {
      servers = {
        nil_ls = {
          enable = true;
          package = null;
          extraOptions = {
            settings = {
              nil = {
                formatting = {command = ["alejandra"];};
                nix = {
                  maxMemoryMB = 4 * 1024;
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

  home.packages = with pkgs; [
    nil
    alejandra
  ];
}
