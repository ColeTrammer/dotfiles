{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      settings = {
        previewers = {
          builtin = {
            extensions =
              let
                image_preview = [
                  "chafa"
                  "{file}"
                  "--format=symbols"
                ];
              in
              {
                png = image_preview;
                jpg = image_preview;
                jpeg = image_preview;
                gif = image_preview;
                webp = image_preview;
                svg = image_preview;
              };
          };
        };
        winopts = {
          width = 0.8;
          height = 0.8;
          row = 0.5;
          col = 0.5;
          preview = {
            scrollchars = [
              "┃"
              ""
            ];
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    chafa
  ];
}
