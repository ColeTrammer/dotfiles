{ config, lib, ... }:
{
  options = {
    steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
  };
}
