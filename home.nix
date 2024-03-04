{ inputs, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./git.nix
    ./nvim
    ./tmux.nix
  ];

  # home.username = "colet";
  # home.homeDirectory = "/home/colet";

  home.stateVersion = "23.11";

  # Packages
  home.packages = [
    pkgs.fd
  ];

  # Bash
  programs.bash.enable = true;
  programs.bash.historyFileSize = 1000000;
  programs.bash.historySize = 1000000;
  programs.bash.initExtra = ''
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
  '';

  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.eza.enableAliases = true;
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      cmd_duration.disabled = true;
    };
  };
  programs.zoxide.enable = true;

  # Shell aliases.
  home.shellAliases = {
    cat = "bat";
    cd = "z";
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  # gpgKey = "56CA6B8E58EB0E7B";

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Workspace"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    allowOther = true;
  };

  programs.home-manager.enable = true;
}
