{
  config,
  helpers,
  lib,
  ...
}:
{
  options = {
    nvim.blink-cmp = {
      extraSources = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = ''Extra completion sources.'';
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.blink-cmp = {
        enable = true;
        # DeferredUIEnter and not InsertEnter so we get completions in command mode.
        lazyLoad.settings.event = "DeferredUIEnter";
        settings = {
          appearance = {
            use_nvim_cmp_as_default = false;
            nerd_font_variant = "normal";
          };
          completion = {
            list = {
              selection = helpers.luaRawExpr ''
                return function(ctx)
                  return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                end
              '';
            };
            menu = {
              draw = {
                components = {
                  kind_icon = {
                    ellipsis = false;
                    text = helpers.luaRawExpr ''
                      return function(ctx)
                        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                        return kind_icon
                      end
                    '';
                    highlight = helpers.luaRawExpr ''
                      return function(ctx)
                        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                        return hl
                      end
                    '';
                  };
                };
                treesitter = [ "lsp" ];
              };
              border = "single";
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window = {
                border = "single";
              };
            };
            ghost_text = {
              enabled = true;
            };
          };
          sources = {
            default = [
              "lsp"
              "path"
              "buffer"
            ] ++ config.nvim.blink-cmp.extraSources;
          };
          keymap = {
            preset = "enter";
            cmdline = {
              preset = "default";
              "<Tab>" = [
                "select_next"
                "fallback"
              ];
              "<S-Tab>" = [
                "select_prev"
                "fallback"
              ];
            };
          };
        };
      };
      keymaps = [
        {
          mode = "n";
          key = "<leader>ua";
          action = helpers.luaRaw ''
            (function()
              local enabled = true
              return function()
                vim.b.completion = not enabled
                enabled = not enabled
              end
            end)()
          '';
          options.desc = ''Toggle Auto-Complete'';
        }
      ];
      autoGroups.disableCmp.clear = true;
      autoCmd = [
        {
          event = [ "FileType" ];
          pattern = [
            "NeogitCommitMessage"
            "gitcommit"
          ];
          group = "disableCmp";
          callback = helpers.luaRawExpr ''
            return function()
              vim.b.completion = false
            end
          '';
        }
      ];
    };
  };
}
