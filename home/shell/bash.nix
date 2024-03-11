{...}: {
  programs.bash = {
    enable = true;
    historyFileSize = 1000000;
    historySize = 1000000;
    initExtra = ''
      export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
    '';
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    files = [
      ".bash_history"
    ];
  };
}
