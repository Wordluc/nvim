print("Welcome to C#")
Default_setup("csharp_ls")
Default_setup("typescript-tools")
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
			.convertDto()
end, { bang = true, nargs = '*' })

local glob = require('vim.glob')
local poll = require("vim.lsp._watchfiles")._poll_exclude_pattern
poll = poll + glob.to_lpeg("**/*.{csproj,sln,slnf}")
poll = poll + glob.to_lpeg("**/*.{js,css}")
poll = poll + glob.to_lpeg("**/bin/**")
poll = poll + glob.to_lpeg("**/obj/**")
require("vim.lsp._watchfiles")._poll_exclude_pattern = poll
