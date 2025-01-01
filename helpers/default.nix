{ lib, ... }@args:
let
  modules = lib.filesystem.listFilesRecursive ./. |> builtins.filter (name: name != ./default.nix);
in
modules |> map (f: (import f) args) |> lib.attrsets.mergeAttrsList
