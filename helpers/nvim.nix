let
  luaExpr = s: builtins.substring 7 (-1) s;
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
