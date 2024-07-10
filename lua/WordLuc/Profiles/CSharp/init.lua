print("Welcome to C#")

vim.api.nvim_create_user_command('Gnamespace', function()
	local dir = vim.fn.expand("%:.")
	local namespace = {}
	for segment in dir:gmatch("[^/|\\]+") do
		table.insert(namespace, segment)
	end
	local newPath = table.concat(namespace, ".", 1, #namespace - 1)
	vim.api.nvim_feedkeys("inamespace " .. newPath .. ";", "n", true)
end, { bang = true, nargs = '*' })
vim.api.nvim_create_user_command('Gtypescript', function()
	require("FromC#ToTypescript")
			.convertDto("")
end, { bang = true, nargs = '*' })


