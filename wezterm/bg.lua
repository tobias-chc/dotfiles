-- Toggle bg transparency
local bg_transparent = true

local background = {
	{
		source = {
			Color = "#282c35",
		},
		width = "100%",
		height = "100%",
		opacity = 0.77,
	},
}

local function toggle_transparency()
	bg_transparent = not bg_transparent
	background[1].opacity = bg_transparent and 0.77 or 1.0
	return background
end

return {
	background = background,
	toggle_transparency = toggle_transparency,
}
