{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.fzf.enable =
      lib.mkEnableOption "fzf"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.fzf.enable {
    programs.fzf = {
      enable = true;
    };

    programs.bash.initExtra = lib.mkOrder 0 ''
      source ${pkgs.vimPlugins.tokyonight-nvim}/extras/fzf/tokyonight_night.zsh
    '';

    programs.zsh.initExtra = lib.mkOrder 0 ''
      source ${pkgs.vimPlugins.tokyonight-nvim}/extras/fzf/tokyonight_night.zsh
    '';
  };
}
