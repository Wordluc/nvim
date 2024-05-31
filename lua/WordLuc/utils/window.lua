local M = {}
M.open_buffer = function(position,size)
	local w=vim.api.nvim_open_win(0, true, {
		relative = "editor",
		style = "minimal",
		border = "rounded",
		row = position.y+1,
		col = position.x,
		width = size.x,
		height = size.y,
	})
	M.size = size
	local buffer = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_cursor(w, {1,1})
	return {buf=buffer,win=w}
end

M.write_pixel = function(buffer, x,y,v)
	vim.api.nvim_buf_set_text(buffer, y,x,y,x+1, {v})
	vim.api.nvim_win_set_cursor(0, {1,1})
end

M.fill_buffer = function(buffer,val)
	local str=string.rep(val, M.size.x)
	vim.api.nvim_set_current_buf(buffer)
	for i = 0, M.size.y-1 do
		vim.api.nvim_buf_set_lines(buffer, i, i, false, {str})
	end
	vim.api.nvim_win_set_cursor(0, {1,1})
end

return M
