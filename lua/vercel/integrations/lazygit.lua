local M = {}

local override = {
	inactiveBorderColor = { fg = "StatusLineNC" },
}

--- Override the lazygit theme so the inactive border uses the inactive
--- foreground color (`secondary`) instead of the border color.
--- Covers both snacks.nvim and AstroUI (AstroVim's toggleterm-based lazygit).
function M.apply()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.config then
		snacks.config.lazygit = vim.tbl_deep_extend("force", snacks.config.lazygit or {}, {
			theme = override,
		})
	end

	local ok2, astroui = pcall(require, "astroui")
	if ok2 and type(astroui.config.lazygit) == "table" then
		astroui.config.lazygit.theme = vim.tbl_deep_extend("force", astroui.config.lazygit.theme or {}, override)
	end
end

return M
