{
  programs.nixvim = {
    plugins.dressing = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        select.backend = [ "fzf_lua" ];
      };
    };
  };
  nvim.plugins.dressing.dependencies = [ "fzf-lua" ];
}
