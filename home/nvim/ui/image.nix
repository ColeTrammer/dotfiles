{
  programs.nixvim = {
    plugins.image = {
      enable = true;
      editorOnlyRenderWhenFocused = true;
      tmuxShowOnlyInActiveWindow = true;
      hijackFilePatterns = [
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
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };
    };
  };
}
