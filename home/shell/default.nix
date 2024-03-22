{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./bash.nix
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    fd
  ];

  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
  };
}
