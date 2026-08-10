local M = {}

M.colors = require("vercel.colors").getColors("light")
M.config = require("vercel.config")
M.utils = require("vercel.utils")

---@param options table|nil Options
function M.setup(options)
	options = options or {}

	setmetatable(M.config, { __index = vim.tbl_extend("force", M.config.defaults, options) })

	-- Re-apply the colorscheme when the background changes so theme toggles
	-- (e.g. Snacks <leader>ub) stay in sync.
	vim.api.nvim_create_autocmd("OptionSet", {
		group = vim.api.nvim_create_augroup("vercel.nvim", { clear = true }),
		pattern = "background",
		callback = function()
			if (vim.g.colors_name or ""):find("vercel") then
				M.colorscheme()
			end
		end,
	})
end

function M.colorscheme()
	vim.api.nvim_command("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.api.nvim_command("syntax reset")
	end

	vim.g.VM_theme_set_by_colorscheme = true
	vim.o.termguicolors = true
	vim.g.colors_name = "vercel"

	M.colors = require("vercel.colors").getColors(M.config.theme or vim.opt.background:get())

	M.set_terminal_colors()
	M.set_groups()
	M.set_bufferline_highlights()
end

---Apply BufferLine* highlight groups directly so users don't need to wire
---`opts.highlights` into bufferline.nvim themselves.
function M.set_bufferline_highlights()
	local bufferline = require("vercel.integrations.bufferline")
	M.highlights = { bufferline = bufferline.highlights(M.config) }
	for name, opts in pairs(M.highlights.bufferline) do
		vim.api.nvim_set_hl(0, bufferline.group_name(name), opts)
	end
end

function M.set_terminal_colors()
	local c = M.colors
	local bright = function(color)
		return M.utils.mix(color, "#ffffff", 0.64)
	end
	local is_light = (M.config.theme or vim.opt.background:get()) == "light"

	vim.g.terminal_color_0 = is_light and c.foreground or c.secondary -- ansiBlack
	vim.g.terminal_color_1 = c.red
	vim.g.terminal_color_2 = c.green
	vim.g.terminal_color_3 = c.yellow
	vim.g.terminal_color_4 = c.blue
	vim.g.terminal_color_5 = c.purple
	vim.g.terminal_color_6 = c.cyan
	vim.g.terminal_color_7 = c.background -- ansiWhite
	vim.g.terminal_color_8 = is_light and c.secondary or c.foreground -- ansiBrightBlack
	vim.g.terminal_color_9 = bright(c.red)
	vim.g.terminal_color_10 = bright(c.green)
	vim.g.terminal_color_11 = bright(c.yellow)
	vim.g.terminal_color_12 = bright(c.blue)
	vim.g.terminal_color_13 = bright(c.purple)
	vim.g.terminal_color_14 = bright(c.cyan)
	vim.g.terminal_color_15 = c.background -- ansiBrightWhite
	vim.g.terminal_color_background = M.colors.background
	vim.g.terminal_color_foreground = M.colors.foreground
end

function M.set_groups()
	local bg = M.config.transparent and "NONE" or M.colors.background
	local diff_add = M.utils.shade(M.colors.green, 0.5, M.colors.background)
	local diff_delete = M.utils.shade(M.colors.red, 0.5, M.colors.background)
	local diff_change = M.utils.shade(M.colors.yellow, 0.5, M.colors.background)
	local diff_text = M.utils.shade(M.colors.property, 0.5, M.colors.background)

	local groups = {
		-- base
		Normal = { fg = M.colors.foreground, bg = bg },
		LineNrAbove = { fg = M.colors.lineNumber },
		LineNr = { fg = M.colors.lineNumberActive },
		LineNrBelow = { fg = M.colors.lineNumber },
		ColorColumn = {
			bg = M.utils.shade(M.colors.string, 0.5, M.colors.background),
		},
		Conceal = {},
		Cursor = { fg = M.colors.foreground },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		CursorLine = { bg = M.colors.select },
		CursorColumn = { link = "CursorLine" },
		Directory = { fg = M.colors.foreground },
		DiffAdd = { bg = bg, fg = diff_add },
		DiffChange = { bg = bg, fg = diff_change },
		DiffDelete = { bg = bg, fg = diff_delete },
		DiffText = { bg = bg, fg = diff_text },
		EndOfBuffer = { fg = M.colors.blue },
		TermCursor = { link = "Cursor" },
		TermCursorNC = { link = "Cursor" },
		ErrorMsg = { fg = M.colors.red },
		VertSplit = { fg = M.colors.border, bg = "NONE" },
		Winseparator = { link = "VertSplit" },
		SignColumn = { link = "Normal" },
		Folded = { fg = M.colors.foreground, bg = M.colors.popup },
		FoldColumn = { link = "SignColumn" },
		IncSearch = {
			bg = M.utils.mix(M.colors.yellow, M.colors.background, 0.66),
			fg = M.colors.background,
		},
		Substitute = { link = "IncSearch" },
		CursorLineNr = { fg = M.colors.secondary },
		MatchParen = { fg = M.colors.pink },
		ModeMsg = { link = "Normal" },
		MsgArea = { link = "Normal" },
		-- MsgSeparator = {},
		MoreMsg = { fg = M.colors.blue },
		NonText = { fg = M.colors.lineNumber },
		NormalFloat = { bg = bg },
		FloatBorder = { fg = M.colors.border },
		NormalNC = { link = "Normal" },
		Pmenu = { link = "NormalFloat" },
		PmenuSel = { bg = M.colors.menu },
		PmenuSbar = {
			bg = M.utils.shade(M.colors.background, 0.5, M.colors.background),
		},
		PmenuThumb = { bg = M.colors.scrollbar },
		Question = { fg = M.colors.purple },
		QuickFixLine = { fg = M.colors.purple },
		SpecialKey = { fg = M.colors.property },
		StatusLine = { fg = M.colors.foreground, bg = bg },
		StatusLineNC = {
			fg = M.colors.secondary,
			bg = M.config.transparent and "NONE" or M.colors.popup,
		},
		TabLine = {
			fg = M.colors.secondary,
			bg = bg,
		},
		TabLineFill = { link = "TabLine" },
		TabLineSel = {
			bg = M.colors.background,
			fg = M.colors.foreground,
		},
		Search = { bg = M.utils.mix(M.colors.yellow, M.colors.background, 0.40) },
		SpellBad = { undercurl = true, sp = M.colors.red },
		SpellCap = { undercurl = true, sp = M.colors.purple },
		SpellLocal = { undercurl = true, sp = M.colors.blue },
		SpellRare = { undercurl = true, sp = M.colors.yellow },
		Title = { fg = M.colors.blue, bold = true },
		Visual = { bg = M.colors.select },
		VisualNOS = { link = "Visual" },
		WarningMsg = { fg = M.colors.yellow },
		Whitespace = { fg = M.colors.placeholder },
		WildMenu = { bg = M.colors.menu },
		Comment = {
			fg = M.colors.placeholder,
			italic = M.config.italics.comments or false,
		},

		Constant = { fg = M.colors.blue },
		String = {
			fg = M.colors.string,
			italic = M.config.italics.strings or false,
		},
		Character = { fg = M.colors.string },
		Number = { fg = M.colors.blue },
		Boolean = { fg = M.colors.blue },
		Float = { link = "Number" },

		Identifier = { fg = M.colors.foreground },
		Function = { fg = M.colors.purple },
		Method = { fg = M.colors.purple },
		Property = { fg = M.colors.blue },
		Field = { link = "Property" },
		Parameter = { fg = M.colors.foreground },
		Statement = { fg = M.colors.pink },
		Conditional = { fg = M.colors.pink },
		-- Repeat = {},
		Label = { fg = M.colors.purple },
		Operator = { fg = M.colors.pink },
		Keyword = { link = "Statement", italic = M.config.italics.keywords or false },
		Exception = { fg = M.colors.pink },

		PreProc = { link = "Keyword" },
		-- Include = {},
		Define = { fg = M.colors.blue },
		Macro = { link = "Define" },
		PreCondit = { fg = M.colors.pink },

		Type = { fg = M.colors.purple },
		Struct = { link = "Type" },
		Class = { link = "Type" },

		-- StorageClass = {},
		-- Structure = {},
		-- Typedef = {},

		Attribute = { fg = M.colors.blue },
		Punctuation = { fg = M.colors.property },
		Special = { fg = M.colors.property },

		SpecialChar = { fg = M.colors.red },
		Tag = { fg = M.colors.string },
		Delimiter = { fg = M.colors.property },
		-- SpecialComment = {},
		Debug = { fg = M.colors.foreground },

		Underlined = { underline = true },
		Bold = { bold = true },
		Italic = { italic = true },
		Ignore = { fg = M.colors.background },
		Error = { link = "ErrorMsg" },
		Todo = { fg = M.colors.yellow, bold = true },

		-- LspCodeLens = {},
		-- LspCodeLensSeparator = {},
		LspInlayHint = { link = "Comment" },
		-- LspReferenceRead = {},
		-- LspReferenceText = {},
		-- LspReferenceWrite = {},
		-- LspSignatureActiveParameter = {},

		DiagnosticError = { link = "Error" },
		DiagnosticWarn = { link = "WarningMsg" },
		DiagnosticInfo = { fg = M.colors.blue },
		DiagnosticHint = { fg = M.colors.blue },
		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
		DiagnosticUnderlineError = { undercurl = true, link = "DiagnosticError" },
		DiagnosticUnderlineWarn = { undercurl = true, link = "DiagnosticWarn" },
		DiagnosticUnderlineInfo = { undercurl = true, link = "DiagnosticInfo" },
		DiagnosticUnderlineHint = { undercurl = true, link = "DiagnosticHint" },
		-- DiagnosticFloatingError = {},
		-- DiagnosticFloatingWarn = {},
		-- DiagnosticFloatingInfo = {},
		-- DiagnosticFloatingHint = {},
		-- DiagnosticSignError = {},
		-- DiagnosticSignWarn = {},
		-- DiagnosticSignInfo = {},
		-- DiagnosticSignHint = {},

		["@text"] = { fg = M.colors.foreground },
		["@texcolorscheme.literal"] = { link = "Property" },
		-- ["@texcolorscheme.reference"] = {},
		["@texcolorscheme.strong"] = { link = "Bold" },
		["@texcolorscheme.italic"] = { link = "Italic" },
		["@texcolorscheme.title"] = { link = "Keyword" },
		["@texcolorscheme.uri"] = {
			fg = M.colors.blue,
			sp = M.colors.blue,
			underline = true,
		},
		["@texcolorscheme.underline"] = { link = "Underlined" },
		["@symbol"] = { fg = M.colors.property },
		["@texcolorscheme.todo"] = { link = "Todo" },
		["@comment"] = { link = "Comment" },
		["@punctuation"] = { link = "Punctuation" },
		["@punctuation.bracket"] = { fg = M.colors.foreground },
		["@punctuation.delimiter"] = { fg = M.colors.foreground },
		["@punctuation.terminator.statement"] = { link = "Delimiter" },
		["@punctuation.special"] = { fg = M.colors.pink },
		["@punctuation.separator.keyvalue"] = { fg = M.colors.pink },

		["@texcolorscheme.diff.add"] = { fg = M.colors.blue },
		["@texcolorscheme.diff.delete"] = { fg = M.colors.pink },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constancolorscheme.builtin"] = { link = "Keyword" },
		-- ["@constancolorscheme.macro"] = {},
		-- ["@define"] = {},
		-- ["@macro"] = {},
		["@string"] = { link = "String" },
		["@string.escape"] = { fg = M.utils.shade(M.colors.string, 0.45) },
		["@string.special"] = { fg = M.utils.shade(M.colors.purple, 0.45) },
		-- ["@character"] = {},
		-- ["@character.special"] = {},
		["@number"] = { link = "Number" },
		["@number.tsx"] = { link = "Constant" },
		["@boolean"] = { link = "Boolean" },
		-- ["@float"] = {},
		["@function"] = {
			link = "Function",
			italic = M.config.italics.functions or false,
		},
		["@function.call"] = { link = "Function" },
		["@function.builtin"] = { link = "Function" },
		-- ["@function.macro"] = {},
		["@parameter"] = { link = "Parameter" },
		["@method"] = { link = "Function" },
		["@field"] = { link = "Property" },
		["@property"] = { link = "Property" },
		["@constructor"] = { fg = M.colors.purple },
		-- ["@conditional"] = {},
		-- ["@repeat"] = {},
		["@label"] = { link = "Label" },
		["@operator"] = { link = "Operator" },
		["@exception"] = { link = "Exception" },
		["@variable"] = {
			fg = M.colors.foreground,
			italic = M.config.italics.variables or false,
		},
		["@variable.builtin"] = { fg = M.colors.blue },
		["@variable.member"] = { fg = M.colors.foreground },
		["@variable.parameter"] = {
			fg = M.colors.foreground,
			italic = M.config.italics.variables or false,
		},
		["@type"] = { link = "Type" },
		["@type.definition"] = { fg = M.colors.foreground },
		["@type.builtin"] = { fg = M.colors.blue },
		["@type.qualifier"] = { fg = M.colors.purple },
		["@type.tsx"] = { fg = M.colors.foreground },
		["@module.tsx"] = { fg = M.colors.foreground },
		["@keyword"] = { link = "Keyword" },
		-- ["@storageclass"] = {},
		-- ["@structure"] = {},
		["@namespace"] = { fg = M.colors.blue },
		["@annotation"] = { link = "Label" },
		-- ["@include"] = {},
		-- ["@preproc"] = {},
		["@debug"] = { fg = M.colors.foreground },
		["@tag"] = { link = "Tag" },
		["@tag.builtin"] = { link = "Tag" },
		["@tag.delimiter"] = { fg = M.colors.property },
		["@tag.attribute"] = { fg = M.colors.blue },
		["@tag.jsx.element"] = { fg = M.colors.blue },
		["@tag.tsx"] = { fg = M.colors.blue },
		["@attribute"] = { fg = M.colors.blue },
		["@error"] = { link = "Error" },
		["@warning"] = { link = "WarningMsg" },
		["@info"] = { fg = M.colors.blue },

		-- Specific languages
		-- overrides
		["@label.json"] = { fg = M.colors.property }, -- For json
		["@label.help"] = { link = "@texcolorscheme.uri" }, -- For help files
		["@texcolorscheme.uri.html"] = { underline = true }, -- For html
		["@markup.heading"] = { fg = M.colors.foreground, bold = true }, -- For markdown

		-- semantic highlighting
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.type"] = { link = "@function" },
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { fg = M.colors.purple },
		["@lsp.type.interface"] = { link = "@function" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@text" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.method"] = { link = "@method" },
		["@lsp.type.macro"] = { link = "@label" },
		["@lsp.type.decorator"] = { link = "@label" },
		["@lsp.type.variable"] = { link = "@text" },

		-- specific typescriptreact highlights
		["@type.typescript"] = { fg = M.colors.foreground },
		["@lsp.type.variable.typescript"] = { fg = M.colors.blue },
		["@lsp.type.property.typescript"] = { fg = M.colors.foreground },
		["@lsp.type.typeParameter.typescript"] = { fg = M.colors.purple },
		["@lsp.mod.local.typescript"] = { fg = M.colors.foreground },
		["@lsp.typemod.property.declaration.typescript"] = { fg = M.colors.foreground },
		["@lsp.typemod.variable.declaration.typescript"] = { fg = M.colors.blue },
		["@lsp.typemod.function.declaration.typescript"] = { fg = M.colors.purple },
		["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = M.colors.foreground },

		["@lsp.mod.declaration.typescriptreact"] = { fg = M.colors.purple },
		["@lsp.typemod.variable.local.typescriptreact"] = { fg = M.colors.foreground },
		["@lsp.typemod.variable.declaration.typescriptreact"] = { fg = M.colors.blue },
		["@lsp.typemod.function.declaration.typescriptreact"] = { fg = M.colors.blue },
		["@lsp.typemod.property.declaration.typescriptreact"] = { fg = M.colors.foreground },
		["@lsp.typemod.variable.defaultLibrary.typescriptreact"] = { fg = M.colors.blue },

		["@lsp.type.parameter.typescript"] = { fg = M.colors.foreground },
		["@lsp.type.parameter.typescriptreact"] = { fg = M.colors.foreground },
		["@lsp.typemod.parameter.declaration.typescript"] = { fg = M.colors.foreground },
		["@lsp.typemod.parameter.declaration.typescriptreact"] = { fg = M.colors.foreground },
	}

	-- integrations
	-- groups = vim.tbl_extend("force", groups, require("vercel.integrations.{pack}").highlights())
	groups = vim.tbl_extend("force", groups, require("vercel.integrations.blink-cmp").highlights(M.config))
	groups = vim.tbl_extend("force", groups, require("vercel.integrations.cmp").highlights(M.config))

	-- overrides
	groups = vim.tbl_extend(
		"force",
		groups,
		type(M.config.overrides) == "function" and M.config.overrides(M.config) or M.config.overrides
	)

	for group, parameters in pairs(groups) do
		vim.api.nvim_set_hl(0, group, parameters)
	end
end

return M
