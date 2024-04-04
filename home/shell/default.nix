{lib, ...}: {
  imports = [
    ./bat.nix
    ./bash.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./fzf.nix
    ./git.nix
    ./lf.nix
    ./nix.nix
    ./ripgrep.nix
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
}
