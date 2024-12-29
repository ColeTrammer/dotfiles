{ lib, ... }:
let
  luaExpr =
    s:
    let
      prefix = builtins.substring 0 7 s;
      check = lib.assertMsg (prefix == "return ") "Lua expressions must begin with `return '";
    in
    assert check;
    builtins.substring 7 (-1) s;
  lazyKeyMap =
    spec:
    {
      __unkeyed-1 = spec.key;
      __unkeyed-2 = spec.action;
      mode = spec.mode or "n";
    }
    // (spec.options or { });
in
{
  inherit luaExpr;
  luaRawExpr = s: { __raw = luaExpr s; };
  luaRaw = s: { __raw = s; };
  lua = s: s;
  lazyKeyMaps = map lazyKeyMap;
}
