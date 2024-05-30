local M = {}
M.open_buffer = function(position,size)
	vim.api.nvim_open_win(-1, true, {
		relative = "editor",
		style = "minimal",
		border = "rounded",
		row = position.y,
		col = position.x,
		width = size.x,
		height = size.y+1,
	})
	M.size = size
	local buffer = vim.api.nvim_create_buf(true, true)
	return buffer
end

M.write_pixel = function(buffer, y,x)
	vim.api.nvim_buf_set_text(buffer, y,x,y,x+1, {"o"})
end

M.fill_buffer = function(buffer,val)
	local str=string.rep(val, M.size.x)
	vim.api.nvim_set_current_buf(buffer)
	for i = 0, M.size.y  do
		vim.api.nvim_buf_set_lines(buffer, i, i, false, {str})
	end
end

return M
