{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lint.lintersByFt = {
      dockerfile = [ "hadolint" ];
    };
    plugins.lsp.servers.dockerls = {
      enable = true;
    };
    plugins.lsp.servers.docker_compose_language_service = {
      enable = true;
    };

    extraConfigLua = ''
      local function set_filetype(pattern, filetype)
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
          pattern = pattern,
          command = "set filetype=" .. filetype,
        })
      end

      set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
    '';
  };

  nvim.otter.allLangs = [ "docker" ];

  home.packages = with pkgs; [ hadolint ];
}
