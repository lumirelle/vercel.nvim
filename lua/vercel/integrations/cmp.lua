local M = {}

--- @param options Options
function M.highlights(options)
	local colors = require("vercel.colors").getColors(options.theme)

	return {
		CmpItemMenu = { fg = colors.foreground },
		CmpItemAbbr = { fg = colors.foreground },
		CmpItemAbbrDeprecated = { fg = colors.red, strikethrough = true },
		CmpItemAbbrMatch = { fg = colors.foreground, bg = colors.border, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = colors.foreground, bg = colors.border, bold = true },

		-- kind support
		CmpItemKindClass = { fg = colors.blue },
		CmpItemKindInterface = { fg = colors.blue },
		CmpItemKindStruct = { fg = colors.blue },
		CmpItemKindEnum = { fg = colors.blue },
		CmpItemKindEnumMember = { fg = colors.blue },
		CmpItemKindTypeParameter = { fg = colors.blue },
		CmpItemKindMethod = { fg = colors.purple },
		CmpItemKindFunction = { fg = colors.purple },
		CmpItemKindConstructor = { fg = colors.blue },
		CmpItemKindEvent = { fg = colors.pink },
		CmpItemKindOperator = { fg = colors.pink },
		CmpItemKindField = { fg = colors.blue },
		CmpItemKindProperty = { fg = colors.blue },
		CmpItemKindVariable = { fg = colors.foreground },
		CmpItemKindConstant = { fg = colors.blue },
		CmpItemKindValue = { fg = colors.blue },
		CmpItemKindReference = { fg = colors.pink },
		CmpItemKindColor = { fg = colors.pink },
		CmpItemKindModule = { fg = colors.blue },
		CmpItemKindFile = { fg = colors.yellow },
		CmpItemKindFolder = { fg = colors.yellow },
		CmpItemKindSnippet = { fg = colors.purple },
		CmpItemKindText = { fg = colors.secondary },
		CmpItemKindKeyword = { fg = colors.pink },
		CmpItemKindUnit = { fg = colors.yellow },
	}
end

return M
