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
              selection = {
                preselect = helpers.luaRawExpr ''
                  return function(ctx)
                    return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
                  end
                '';
                auto_insert = true;
              };
            };
            menu = {
              auto_show = helpers.luaRawExpr ''
                return function(ctx)
                  return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
                end
              '';
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
            default =
              let
                sources = [
                  "lsp"
                  "path"
                  "buffer"
                  "snippets"
                ] ++ config.nvim.blink-cmp.extraSources;
              in
              helpers.luaRawExpr ''
                return function(ctx)
                  local success, node = pcall(vim.treesitter.get_node)
                  if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                    return { "buffer" }
                  elseif vim.b.only_snippets then
                    return { "snippets" }
                  else
                    return ${helpers.nixvim.toLuaObject sources}
                  end
                end
              '';
            providers.snippets = helpers.luaRawExpr ''
              return {
                should_show_items = function(ctx)
                  return ctx.trigger.initial_kind ~= "trigger_character"
                end,
              }
            '';
          };
          keymap = {
            preset = "enter";
            "<C-x>" = [
              (helpers.luaRawExpr ''
                return function(cmp)
                  local result = cmp.show()
                  if result then
                    vim.b.only_snippets = true
                  end
                  return result
                end
              '')
            ];
            "<C-e>" = [
              (helpers.luaRawExpr ''
                return function(cmp)
                  vim.b.only_snippets = false
                  return cmp.hide()
                end
              '')
              "fallback"
            ];
            "<CR>" = [
              (helpers.luaRawExpr ''
                return function(cmp)
                  local result = cmp.accept()
                  if result then
                    vim.b.only_snippets = false
                  end
                  return result
                end
              '')
              "fallback"
            ];
          };
          cmdline = {
            enabled = true;
            keymap = {
              # ctrl+enter on with my terminal setup
              "<C-^>" = [
                (helpers.luaRawExpr ''
                  return function(cmp)
                    if cmp.is_ghost_text_visible() or cmp.is_menu_visible() then
                      return cmp.accept_and_enter()
                    end
                  end
                '')
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
      autoGroups.resetSnippetMode.clear = true;
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
        {
          event = [ "InsertLeave" ];
          group = "resetSnippetMode";
          callback = helpers.luaRawExpr ''
            return function()
              vim.b.only_snippets = false
            end
          '';
        }
      ];
    };
    nvim.plugins.lsp.dependencies = [ "blink-cmp" ];
  };
}
