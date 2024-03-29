{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 50000;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    shell = "${pkgs.zsh}/bin/zsh";

    extraConfig = ''
      # Terminal features
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -sa terminal-features ",xterm*:RGB"

      # Renumber windows
      set-option -g renumber-windows on

      # Disable confirmation prompt when killing panes
      bind-key x kill-pane

      # Stay in tmux unless explicitly detaching
      set -g detach-on-destroy off

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Copy mode keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Sensible split window shortcuts
      bind '-' split-window -v -c "#{pane_current_path}"
      bind '|' split-window -h -c "#{pane_current_path}"

      # Passthrough
      set -g allow-passthrough on

      # Status bar on topset -g status-position top
      set -g status-position top

      # Reload config
      bind R source-file ~/.config/tmux/tmux.conf
    '';

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.tmux-fzf
      tmuxPlugins.sessionist
      tmuxPlugins.session-wizard
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          # The color scheme must come first so that it doesn't overwrite the status bar.
          source ${pkgs.vimPlugins.tokyonight-nvim}/extras/tmux/tokyonight_night.tmux
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };

  programs.fzf.tmux = {
    enableShellIntegration = true;
    shellIntegrationOptions = [
      "-p"
    ];
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [".tmux"];
  };

  programs.bash.initExtra = lib.mkOrder 10000 ''
    [ -z "$TMUX" ] && { tmux attach || exec tmux new-session; }
  '';

  programs.zsh.initExtraFirst = lib.mkOrder 0 ''
    [ -z "$TMUX" ] && { tmux attach || exec tmux new-session; }
  '';

  systemd.user.services.tmux = {
    Unit = {
      Description = "Tmux";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "forking";
      ExecStart = "${config.programs.tmux.package}/bin/tmux start-server";
      ExecStop = "${config.programs.tmux.package}/bin/tmux kill-server";
    };

    Install.WantedBy = ["default.target"];
  };
}
