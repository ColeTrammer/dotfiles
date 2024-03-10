{ ... }:

{
  home.persistence."/persist/home" = {
    directories = [ ".local/share/keyrings" ];
    allowOther = true;
  };
}
