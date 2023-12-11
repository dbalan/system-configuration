local wezterm = require("wezterm")
local act = wezterm.action
local mods = "CTRL|SHIFT"
local keymap = {
  {
    key = "Backspace",
    mods = mods,
    action = act.ClearScrollback("ScrollbackAndViewport"),
  },
}

return {
  color_scheme = "GruvboxDark",
  enable_wayland = true,
  font = wezterm.font("Iosevka Extended", { weight = "Regular" }),
  font_size = 12.0,
  force_reverse_video_cursor = true,
  hide_tab_bar_if_only_one_tab = true,
  keys = keymap,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  default_cursor_style = "BlinkingBar",
  window_padding = {
    left = 2,
    right = 0,
    top = 0.1,
    bottom = 0,
  },

}
