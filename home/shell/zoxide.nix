{ ... }:

{
  programs.zoxide = {
    enable = true;
  };

  home.shellAliases = {
    cd = "z";
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [ ".local/share/zoxide" ];
  };
}
