local function horizontalResize(amount, increment)
	local x = vim.api.nvim_win_get_width(0)
	if amount ~= 0 then
		vim.fn.setreg("y", math.sqrt(amount * amount))
	end

	if increment then
		vim.api.nvim_win_set_width(0, x + tonumber(vim.fn.getreg("y")))
	else
		vim.api.nvim_win_set_width(0, x - tonumber(vim.fn.getreg("y")))
	end
end

local function verticalResize(amount, increment)
	local y = vim.api.nvim_win_get_height(0)
	if amount ~= 0 then
		vim.fn.setreg("y", math.sqrt(amount * amount))
	end

	if increment then
		vim.api.nvim_win_set_height(0, y + tonumber(vim.fn.getreg("y")))
	else
		vim.api.nvim_win_set_height(0, y - tonumber(vim.fn.getreg("y")))
	end
end

vim.keymap.set("n", "<C-l>", function() horizontalResize(vim.v.count, false) end)
vim.keymap.set("n", "<C-h>", function() horizontalResize(vim.v.count, true) end)

vim.keymap.set("n", "<C-k>", function() verticalResize(vim.v.count, true) end)
vim.keymap.set("n", "<C-j>", function() verticalResize(vim.v.count, false) end)
