{ lib, ... }:
let
  notMatchingPrefixes = prefixes: s: builtins.all (prefix: !lib.path.hasPrefix prefix s) prefixes;
  hasNixExtension = s: lib.hasSuffix ".nix" s;
in
{
  globNix =
    dir: ignorePrefixes:
    lib.filesystem.listFilesRecursive dir
    |> builtins.filter (notMatchingPrefixes ignorePrefixes)
    |> builtins.filter hasNixExtension;
}
