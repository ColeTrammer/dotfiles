let
  luaExpr = s: builtins.substring 7 (-1) s;
in
{
  inherit luaExpr;
  luaRawExpr = s: { __raw = luaExpr s; };
  luaRaw = s: { __raw = s; };
  lua = s: s;
}
