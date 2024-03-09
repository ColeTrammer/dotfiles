{ pkgs, ... }:

{
  config = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      customPaneNavigationAndResize = true;
      disableConfirmationPrompt = true;
      mouse = true;
      escapeTime = 0;
      keyMode = "vi";
      shortcut = "a";

      extraConfig = ''
        # Terminal features
        set-option -sa terminal-overrides ",xterm*:Tc"
        set-option -sa terminal-features ",xterm*:RGB"

        # Color scheme
        source ${pkgs.vimPlugins.tokyonight-nvim}/extras/tmux/tokyonight_night.tmux

        # Renumber windows
        set-option -g renumber-windows on

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
      '';

      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
      ];
    };
  };
}
