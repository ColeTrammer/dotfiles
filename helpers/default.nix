{ lib, ... }@args:
let
  modules = [ ./nvim.nix ];
in
modules |> map (f: (import f) args) |> lib.attrsets.mergeAttrsList
