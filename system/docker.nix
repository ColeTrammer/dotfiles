{ config, lib, ... }:
{
  options = {
    docker.enable = lib.mkEnableOption "Docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
    };

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [ "/var/lib/docker" ];
    };
  };
}
