local wezterm = require("wezterm")
local config = require("config")
local bg = require("bg")
require("events")

-- Apply color scheme based on the WEZTERM_THEME environment variable
local themes = {
	nord = "Nord (Gogh)",
	onedark = "One Dark (Gogh)",
}
local success, stdout, stderr = wezterm.run_child_process({ os.getenv("SHELL"), "-c", "printenv WEZTERM_THEME" })
local selected_theme = stdout:gsub("%s+", "") -- Remove all whitespace characters including newline
config.color_scheme = themes[selected_theme]

-- Add background configuration
config.background = bg.background

-- Disable all default key bindings
config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
	-- Add keybinding for toggling transparency
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			window:set_config_overrides({ background = bg.toggle_transparency() })
		end),
	},
	-- Define only the Ctrl+Cmd+T binding to open a new tab (new terminal)
	{ key = "T", mods = "CTRL|CMD", action = act.SpawnTab("DefaultDomain") },
	-- Close current tab with Ctrl+Cmd+W
	{ key = "W", mods = "CTRL|CMD", action = act.CloseCurrentTab({ confirm = false }) },
	-- Copy (Ctrl+Shift+C on Linux/Windows, Cmd+C on macOS)
	{ key = "C", mods = "CMD", action = act.CopyTo("Clipboard") },
	-- Paste (Ctrl+Shift+V on Linux/Windows, Cmd+V on macOS)
	{ key = "V", mods = "CMD", action = act.PasteFrom("Clipboard") },
}

return config
