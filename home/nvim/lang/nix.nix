{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        nix = ["alejandra"];
      };
    };
    plugins.lsp = {
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

  home.packages = with pkgs; [
    nil
    alejandra
  ];
}