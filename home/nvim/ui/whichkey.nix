{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
    };
    plugins.which-key.registrations."g".name = "+goto";
    plugins.which-key.registrations."z".name = "+fold";
    plugins.which-key.registrations."]".name = "+next";
    plugins.which-key.registrations."[".name = "+prev";
  };
}
