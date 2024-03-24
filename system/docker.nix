{...}: {
  virtualisation.docker = {
    enable = true;
  };

  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/lib/docker"
    ];
  };
}
