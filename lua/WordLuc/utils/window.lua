local parentSize = {
	x = vim.api.nvim_win_get_width(0),
	y = vim.api.nvim_win_get_height(0)
}
local childSize = {
	x = math.floor(parentSize.x * (1 - 0.30)),
	y = math.floor(parentSize.y * (1 - 0.30))
}
local childPosition = {
	y = vim.api.nvim_win_get_height(0) - childSize.y / 2 - parentSize.y / 2,
	x = vim.api.nvim_win_get_width(0) - childSize.x / 2 - parentSize.x / 2
}
local M = {}

M.open_buffer = function(position,size)
	vim.api.nvim_open_win(-1, true, {
		relative = "editor",
		style = "minimal",
		border = "rounded",
		row = position.y,
		col = position.x,
		width = size.x,
		height = size.y,
	})
	local buffer = vim.api.nvim_create_buf(true, true)
	return buffer
end

M.write_pixel = function(buffer, xG, yG)
	local x = xG
	local y = yG
	vim.api.nvim_buf_set_text(buffer, y, x, y+1, x+1, {"o"})
end

M.fill_buffer = function(buffer,val)
	local str=string.rep(val, childSize.x)
	vim.api.nvim_set_current_buf(buffer)
	for i = 0, childSize.y -1 do
		vim.api.nvim_buf_set_lines(buffer, i, i, false, {str})
	end
end

local buf = M.open_buffer(childPosition, childSize)
M.fill_buffer(buf, " ")
M.write_pixel(buf, 9, 9)
return M
