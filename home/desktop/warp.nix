{pkgs, ...}: {
  home.packages = with pkgs; [
    cloudflare-warp
  ];

  systemd.user.services = {
    warp-taskbar = {
      Unit = {
        Description = "Cloudflare Warp taskbar";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.cloudflare-warp}/bin/warp-taskbar";
        ExecStop = "pkill warp-taskbar";
      };

      Install.WantedBy = ["default.target"];
    };
  };

  home.persistence."/persist/home" = {
    directories = [".local/share/warp"];
    allowOther = true;
  };
}
