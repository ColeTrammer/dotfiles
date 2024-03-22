local wezterm = require("wezterm")
local act = wezterm.action

return {
  font = wezterm.font("FiraCode Nerd Font"),
  font_size = 12.0,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = "tokyonight_night",
  scrollback_lines = 10000,
  window_padding = {
    left = 4,
    right = 4,
    top = 16,
    bottom = 0,
  },
  keys = {
    { key = "Backspace", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
  },
}
