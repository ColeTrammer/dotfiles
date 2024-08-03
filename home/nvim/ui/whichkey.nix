{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "g";
        group = "+goto";
      }
      {
        __unkeyed-1 = "z";
        group = "+fold";
      }
      {
        __unkeyed-1 = "]";
        group = "+next";
      }
      {
        __unkeyed-1 = "[";
        group = "+prev";
      }
    ];
  };
}
