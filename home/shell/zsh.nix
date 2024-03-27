{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
    };
    history = {
      save = 1000000;
      size = 1000000;
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    syntaxHighlighting = {
      enable = true;
    };
    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      source ~/.config/zsh/zsh-settings.sh
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
    ];
  };

  home.file.".config/zsh/zsh-settings.sh".source = ./zsh-settings.sh;

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".local/share/zsh"
    ];
  };
}
