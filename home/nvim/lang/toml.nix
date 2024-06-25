{
  programs.nixvim = {
    plugins.lsp.servers.taplo = {
      enable = true;
    };
  };
  nvim.otter.allLangs = [ "toml" ];
}
