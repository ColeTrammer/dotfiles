{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./bash.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    fd
  ];

  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
  };
}
