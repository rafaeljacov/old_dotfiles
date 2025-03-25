local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_tab_bar = false;
config.font_size = 17
config.font =
  wezterm.font('JetBrainsMonoNL Nerd Font', { weight = 'Bold' })
config.color_scheme = 'Ayu Dark (Gogh)'

return config
