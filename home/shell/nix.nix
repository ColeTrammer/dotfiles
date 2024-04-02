{...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
