{ config, inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../..
  ];

  home = {
    username = "colet";
    homeDirectory = "/home/colet";
    stateVersion = "23.11";
  };

  apps = {
    enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    wezterm.enable = true;
    obs.enable = true;
    steam.enable = true;
    vscode.enable = true;
  };

  desktop.enable = true;
  shell.git.gpgKey = "60DCAA3C4B6F51E3";
  shell.vttest.enable = true;

  programs.zsh.initExtra = ''
    source /persist/secrets/env.sh
  '';

  nvim.lang.cpp.queryDriver = [
    "/nix/store/*/bin/clang*"
    "/nix/store/*/bin/gcc*"
    "/nix/store/*/bin/g++*"
    "${config.home.homeDirectory}/Workspace/os/iros/cross/bin/*"
    "${config.home.homeDirectory}/Workspace/os/serenity/Toolchain/Local/*/bin/*"
  ];

  nixpkgs.config.allowUnfree = true;
}
