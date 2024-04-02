{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bat.nix
    ./bash.nix
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./lf.nix
    ./nix.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    shell.enable =
      lib.mkEnableOption "Shell programs"
      // {
        default = true;
      };
  };

  config = lib.mkIf config.shell.enable {
    home.packages = with pkgs; [
      fd
    ];

    programs = {
      fzf.enable = true;
      ripgrep.enable = true;
    };
  };
}
