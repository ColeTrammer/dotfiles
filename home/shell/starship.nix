{
  config,
  lib,
  ...
}: {
  options = {
    shell.starship = {
      enable =
        lib.mkEnableOption "starship"
        // {
          default = config.shell.enable;
        };
      localIp = lib.mkEnableOption "show local ip over hostname";
    };
  };

  config = let
    presets = "${config.programs.starship.package}/share/starship/presets";
  in
    lib.mkIf config.shell.starship.enable
    {
      programs.starship = {
        enable = true;
        settings = lib.mkMerge [
          (builtins.fromTOML (builtins.readFile "${presets}/nerd-font-symbols.toml"))
          (builtins.fromTOML (builtins.readFile "${presets}/no-runtime-versions.toml"))
          {
            # Global config
            command_timeout = 1000;
            format = "$character";
            right_format = "$all";
            add_newline = false;

            # Module config
            aws.disabled = true;
            localip = {
              disabled = !config.shell.starship.localIp;
              format = "[$localipv4]($style) in ";
            };
            hostname = {
              disabled = config.shell.starship.localIp;
              ssh_only = false;
              detect_env_vars = ["!TMUX" "SSH_CONNECTION"];
            };
            username.disabled = true;
            nix_shell = {
              style = "bold cyan";
              format = "via [$symbol$name]($style) ";
            };
            c = {
              format = "via [$symbol]($style)";
            };
            directory = {
              style = "bold blue";
            };
          }
        ];
      };
    };
}
