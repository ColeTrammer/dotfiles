{ lib, ... }:
{
  imports = [
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./curl.nix
    ./delta.nix
    ./direnv.nix
    ./dua.nix
    ./duf.nix
    ./dust.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./ffmpeg.nix
    ./fzf.nix
    ./git.nix
    ./gstreamer.nix
    ./hyperfine.nix
    ./jq.nix
    ./just.nix
    ./lf.nix
    ./nh.nix
    ./nix-index.nix
    ./nix.nix
    ./oh-my-posh.nix
    ./pistol.nix
    ./ripgrep.nix
    ./starship.nix
    ./tldr.nix
    ./tmux.nix
    ./valgrind.nix
    ./wget.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    shell.enable = lib.mkEnableOption "Shell programs" // {
      default = true;
    };
  };
}
