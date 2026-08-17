local M = {}

--- Override snacks.nvim's lazygit theme so the inactive border uses the
--- inactive foreground color (`secondary`) instead of the border color.
--- Only `inactiveBorderColor` is changed; the active/searching borders keep
--- their default accent color.
function M.apply()
	local ok, snacks = pcall(require, "snacks")
	if not ok or not snacks.config then
		return
	end

	snacks.config.lazygit = vim.tbl_deep_extend("force", snacks.config.lazygit or {}, {
		theme = {
			inactiveBorderColor = { fg = "StatusLineNC" },
		},
	})
end

return M
