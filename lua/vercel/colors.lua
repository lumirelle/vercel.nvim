local M = {}

---@param theme "light" | "dark"
M.getColors = function(theme)
	local colors = {}
	if theme == "light" or vim.o.background == "light" then
		colors.background = "#ffffff" -- Background.default
		colors.foreground = "#171717" -- Foreground.default | Foreground.active
		colors.secondary = "#4d4d4d" -- Foreground.inactive

		colors.border = "#ebebeb" -- Border.default & assist
		colors.placeholder = "#7d7d7d" -- Foreground.placeholder
		colors.scrollbar   = "#858585" -- Background.scrollbar
		colors.lineNumber = "#4d4d4d" -- Foreground.inactive
		colors.lineNumberActive = "#171717" -- Foreground.active
		colors.menu = "#ffffff" -- Background.default
		colors.popup = "#ffffff" -- Background.default
		colors.select = "#ebebeb" -- Background.active

		colors.blue = "#005ff2" -- Foreground.blue
		colors.green = "#107d32" -- Foreground.green
		colors.purple = "#7d00cc" -- Foreground.purple
		colors.red = "#d8001b" -- Foreground.red
		colors.yellow = "#aa4d00" -- Foreground.yellow
		colors.pink = "#c41562" -- Foreground.pink
		colors.cyan = "#01f7f7" -- Foreground.cyan
		colors.black = "#171717" -- terminal.ansiBlack
		colors.white = "#4d4d4d" -- terminal.ansiWhite

		colors.property = "#171717" -- Foreground.default | Foreground.active
		colors.string = "#107d32" -- Foreground.green
	else
		colors.background = "#000000" -- Background.default
		colors.foreground = "#ededed" -- Foreground.default | Foreground.active
		colors.secondary = "#a0a0a0" -- Foreground.inactive

		colors.border = "#1a1a1a" -- Border.default & assist
		colors.placeholder = "#7d7d7d" -- Foreground.placeholder
		colors.scrollbar   = "#959595" -- Background.scrollbar
		colors.lineNumber = "#a0a0a0" -- Foreground.inactive
		colors.lineNumberActive = "#ededed" -- Foreground.active
		colors.menu = "#000000" -- Background.default
		colors.popup = "#000000" -- Background.default
		colors.select = "#1f1f1f" -- Background.active

		colors.blue = "#47a8ff" -- Foreground.blue
		colors.green = "#00ca50" -- Foreground.green
		colors.purple = "#c472fb" -- Foreground.purple
		colors.red = "#ff565f" -- Foreground.red
		colors.yellow = "#ff9300" -- Foreground.yellow
		colors.pink = "#ff4d8d" -- Foreground.pink
		colors.cyan = "#01f7f7" -- Foreground.cyan
		colors.black = "#a0a0a0" -- terminal.ansiBlack
		colors.white = "#ededed" -- terminal.ansiWhite

		colors.property = "#ededed" -- Foreground.default | Foreground.active
		colors.string = "#00ca50" -- Foreground.green
	end

	return colors
end

return M
