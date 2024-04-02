{
  config,
  lib,
  ...
}: {
  options = {
    audio.enable =
      lib.mkEnableOption "Audio"
      // {
        default = true;
      };
  };

  config = lib.mkIf config.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
