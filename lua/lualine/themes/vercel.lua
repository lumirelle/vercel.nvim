local config = require("vercel.init").config
local colors = require("vercel.colors").getColors(config.theme)

local M = {}

M.normal = {
	a = { fg = colors.background, bg = colors.pink, gui = "bold" },
	b = { fg = colors.pink, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

M.visual = {
	a = { fg = colors.background, bg = colors.blue, gui = "bold" },
	b = { fg = colors.blue, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

M.inactive = {
	a = { fg = colors.secondary, bg = colors.background, gui = "bold" },
	b = { fg = colors.secondary, bg = colors.background },
	c = { fg = colors.secondary, bg = config.transparent and "NONE" or colors.background },
}

M.replace = {
	a = { fg = colors.background, bg = colors.red, gui = "bold" },
	b = { fg = colors.red, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

M.insert = {
	a = { fg = colors.background, bg = colors.green, gui = "bold" },
	b = { fg = colors.green, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

M.terminal = {
	a = { fg = colors.background, bg = colors.purple, gui = "bold" },
	b = { fg = colors.purple, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

M.command = {
	a = { fg = colors.background, bg = colors.yellow, gui = "bold" },
	b = { fg = colors.yellow, bg = colors.background },
	c = { fg = colors.foreground, bg = config.transparent and "NONE" or colors.background },
}

return M
