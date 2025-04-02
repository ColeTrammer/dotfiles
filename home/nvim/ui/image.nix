{
  programs.nixvim = {
    plugins.image = {
      enable = true;
      settings = {
        editor_only_render_when_focused = true;
        tmux_show_only_in_active_window = true;
        hijack_file_patterns = [
          "*.png"
          "*.jpg"
          "*.jpeg"
          "*.gif"
          "*.webp"
          "*.avif"
          "*.svg"
        ];
        integrations = {
          markdown = {
            clear_in_insert_mode = true;
            only_render_image_at_cursor = true;
          };
        };
      };
    };
  };
}
