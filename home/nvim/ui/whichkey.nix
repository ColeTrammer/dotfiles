{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
    };
    plugins.which-key.registrations."g".group = "+goto";
    plugins.which-key.registrations."z".group = "+fold";
    plugins.which-key.registrations."]".group = "+next";
    plugins.which-key.registrations."[".group = "+prev";
  };
}
