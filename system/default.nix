{
  helpers,
  inputs,
  pkgs,
  ...
}:
let
  modules = helpers.globNix ./. [ ./default.nix ];
in
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
  ] ++ modules;

  environment.systemPackages = with pkgs; [
    git
    vim
    nix-ld
  ];

  programs.nano.enable = false;
  services.xserver.desktopManager.xterm.enable = false;
}
