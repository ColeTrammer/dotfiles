{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.pistol.enable =
      lib.mkEnableOption "pistol"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.pistol.enable {
    programs.pistol = {
      enable = true;
      associations = [
        {
          mime = "application/json";
          command = "${config.preferences.pager} %pistol-filename%";
        }
        {
          mime = "text/*";
          command = "${config.preferences.pager} %pistol-filename%";
        }
        {
          mime = "inode/directory";
          command = "${pkgs.eza}/bin/eza --tree --git --icons --group-directories-first --color=always %pistol-filename%";
        }
        {
          mime = "image/*";
          command = "${pkgs.chafa}/bin/chafa -O 9 --format symbols %pistol-filename%";
        }
        {
          mime = "video/*";
          command = "${pkgs.termplay}/bin/termplay -q %pistol-filename%";
        }
      ];
    };

    home.packages = with pkgs; [
      chafa
      termplay
    ];
  };
}
