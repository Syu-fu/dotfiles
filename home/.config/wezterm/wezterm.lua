local wezterm = require('wezterm')

local config = {}
config.color_scheme = 'Gruvbox Material (Gogh)'
config.enable_tab_bar = false
config.font = wezterm.font('HackGenConsoleNF')
config.font_size = 14.0
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
