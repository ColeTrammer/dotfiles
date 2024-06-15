{ inputs, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "stickybuf.nvim";
        version = "git";
        src = inputs.stickybuf-nvim;
      })
    ];

    extraConfigLua = ''
      require("stickybuf").setup()
    '';
  };
}
