local M = {}

M.Setup = function()
end

vim.api.nvim_create_user_command('Align', function()
	print(vim.fn.getpos("<"))
end, { bang = true, nargs = '*' })

return M
