{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode-fhs
  ];

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".vscode"
      ".config/Code"
    ];
  };
}
