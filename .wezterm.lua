-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set font to Fira Code
config.font = wezterm.font 'FiraCode Nerd Font'

-- Disable tab bar if only one tab is open
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config

