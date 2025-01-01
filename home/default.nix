{ helpers, ... }:
{
  imports = helpers.globNix ./. [
    ./default.nix
    ./configurations
  ];

  programs.home-manager.enable = true;
}
