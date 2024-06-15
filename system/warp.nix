{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    warp.enable = lib.mkEnableOption "CloudFlare Warp" // {
      default = true;
    };
  };

  config = lib.mkIf config.warp.enable {
    environment.systemPackages = with pkgs; [ cloudflare-warp ];

    systemd = {
      packages = [ pkgs.cloudflare-warp ];
      targets.multi-user.wants = [ "warp-svc.service" ];
    };

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [ "/var/lib/cloudflare-warp" ];
    };
  };
}
