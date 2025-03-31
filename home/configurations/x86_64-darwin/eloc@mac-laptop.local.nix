{
  config,
  lib,
  ...
}:
{
  imports = [
    ../..
  ];

  options = {
    home.persistence = lib.mkOption { type = lib.types.anything; };
  };

  config = {
    home = {
      username = "eloc";
      homeDirectory = "/Users/eloc";
      stateVersion = "24.11";
    };

    apps = {
      alacritty.enable = true;
      kitty.enable = true;
      wezterm.enable = true;
    };

    shell.vttest.enable = true;

    nvim.lang.cpp.queryDriver = [
      "/nix/store/*/bin/clang*"
      "/nix/store/*/bin/gcc*"
      "/nix/store/*/bin/g++*"
      "${config.home.homeDirectory}/Workspace/os/iros/cross/bin/*"
      "${config.home.homeDirectory}/Workspace/os/serenity/Toolchain/Local/*/bin/*"
    ];

    nixpkgs.config.allowUnfree = true;
  };
}
